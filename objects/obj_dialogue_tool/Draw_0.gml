if (!surface_exists(ui_surface)) {
	ui_surface = surface_create(640, 480);
}

if (slide_offset > 0) {
	surface_set_target(ui_surface);
	draw_clear_alpha(c_black, 0);
}

draw_box(box_margin_w, rect_y, 639 - box_margin_w, rect_y + box_height - 1);
draw_formatted_text(face ? text_x_with_face : text_x, text_y, format_basic, limit_lines(wrap_formatted_text(text, face ? 25 : 32, true), 3));

if (face) {
	draw_sprite_ext(spr_bnuuy, 0, box_margin_w + face_offset_w, rect_y + face_offset_h, 2, 2, 0, c_white, 1);
}

draw_formatted_text(box_margin_w, rect_y + box_height + 2, format_bubble, "(F1 to toggle face, F2 to test with blip, F3 to view journal)");

draw_bubble(x_big, 259, pixel_width_big, pixel_height_big);
draw_formatted_text(x_big + 7, 271, format_bubble, "{c,bk}" + limit_lines(wrap_formatted_text(text, width_big, false), 4));
draw_formatted_text(x_big, pixel_height_big + 261, format_bubble, "Large bubble\n(for bosses)");

draw_bubble(x_small + 58, 259, pixel_width_small, pixel_height_small);
draw_formatted_text(x_small + 65, 271, format_bubble, "{c,bk}" + limit_lines(wrap_formatted_text(text, width_small, false), 4));
draw_formatted_text(x_small, pixel_height_small + 261, format_bubble, "Small bubble\n(for random encounters)");

if (slide_offset > 0) {
	surface_reset_target();
	draw_surface(ui_surface, -slide_offset, 0);
	draw_sprite_ext(spr_journal, 0, 640 - slide_offset, 0, 2, 2, 0, c_white, 1);
	
	var journal_lines = string_split(wrap_formatted_text(text, 16, false), "\n");
	var journal_page_1 = "{c,dg}";
	var journal_page_2 = "{c,dg}";
	
	var journal_lines_length = array_length(journal_lines);
	for (var i = 0; i < journal_lines_length && i < 22; i++) {
		if (i < 11) {
			journal_page_1 += journal_lines[i];
			if (i < journal_lines_length - 1 && i < 10) {
				journal_page_1 += "\n";
			}
		} else {
			journal_page_2 += journal_lines[i];
			if (i < journal_lines_length - 1 && i < 21) {
				journal_page_2 += "\n";
			}
		}
	}
	
	if (string_length(journal_page_1) > 0) {
		draw_formatted_text(694 - slide_offset, 69, format_battle, journal_page_1);
	}
	
	if (string_length(journal_page_2) > 0) {
		draw_formatted_text(974 - slide_offset, 69, format_battle, journal_page_2);
	}
}

draw_set_color(c_gray);
draw_set_font(fnt_small);
draw_set_halign(fa_center);
draw_text(320, 458, "UNDERTALE DIALOGUE TOOL v1.03 (WILDFIRE) (C) PYTHON-B5 2024");
draw_set_halign(fa_left);
draw_set_color(c_white);

if (overlay_alpha > 0) {
	draw_set_alpha(overlay_alpha * 0.5);
	draw_set_color(c_black);
	draw_rectangle(0, 0, 639, 479, false);
	draw_set_color(c_white);
	draw_set_alpha(1);
}
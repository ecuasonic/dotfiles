-- -------------------------------------------
--        Staging / Unstaging Maps
-- -------------------------------------------
-- (s) - Stage (add) the file / hunk under the cursor.
-- (u) - Unstage (reset) the file / hunk unde the cursor.
-- (-) - Stage or unstage the file / hunk under the cursor.
-- (U) - Unstage everything.
-- (X) - Discard the change under the cursor.
--
-- -------------------------------------------
--                Diff Maps
-- -------------------------------------------
-- (dd) - Perform a :Gdiffsplit on the file under the cursor.
-- (dv) - Perform a :Gvdiffsplit on the file under the cursor.
--
-- -------------------------------------------
--             Navigation Maps
-- -------------------------------------------
-- (CR) - Open the file under the cursor.
--
-- -------------------------------------------
--              Commit Maps
-- -------------------------------------------
-- (cc) - commit
-- (ca) - commit --amend
-- (ce) - commit --amend --no-edit
-- (cw) - commit --amend --only-reword
return {
    "tpope/vim-fugitive"
}

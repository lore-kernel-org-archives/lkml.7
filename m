Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71FDC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2752089E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390275AbfHHUpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:45:52 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36544 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbfHHUpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:45:51 -0400
Received: by mail-qk1-f193.google.com with SMTP id g18so69977266qkl.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 13:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bhgw+o4B/3gx0f2c2xCh51GNhpAUH3IKPso/TuqCoeo=;
        b=KZ1d++QWagunIIYAYEmi5yggTBawq26u7nfLg/jltgb1fj/MzJxd4qngsux8tW5ynr
         h6zndr4UitwqBo9nUHINJM1uDBIzAjalXmu6oASVAj6bLTQSYVcta9gLaoe6vKyTX823
         +NReg7+u3nIlK9fMOOk+gJoHSFZ/UybSemaVKwi1vqDA7VY00X7jXMpNQ8iwcQ4oZSYX
         ernXpmKf2GoODBvRsMdeZB1q7/w4O0zpAguzNB3fp6KT+tj+q9u7ns9arTZJ92wVFUlz
         rfW7+HZihLT20HQk3J0DOMMkohmvKXhNd7jU84quHPRk3/wohUd91ZPX2m65Jf/zOHmP
         2kkQ==
X-Gm-Message-State: APjAAAVZXkRb5KWMd+pggAgqBB/ScUpfF/SiHOqfPG6jWa1iprPahF7A
        9S0wHsmGh5V8iZDdzSjsid2TTlEKYK38X2pl9k4=
X-Google-Smtp-Source: APXvYqyCp8IPNm4G3NNI1cjHOeiiDeTTDPwCH5aAxuLNo7EEQPLN36feVnDgs3Oztr8t4j0phOqeVmMaOcEteGNK/SI=
X-Received: by 2002:a37:984:: with SMTP id 126mr9286864qkj.3.1565297150449;
 Thu, 08 Aug 2019 13:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <201908090321.bRMBBE6A%lkp@intel.com>
In-Reply-To: <201908090321.bRMBBE6A%lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Aug 2019 22:45:34 +0200
Message-ID: <CAK8P3a0FT1FCkvik++TJxnp8=36+9EW-tjo0UXdGPZxw_MMPfQ@mail.gmail.com>
Subject: Re: [arnd-playground:randconfig-5.3-rc2 32/347] fs/reiserfs/prints.o:
 warning: objtool: __reiserfs_error()+0x80: unreachable instruction
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 9:06 PM kbuild test robot <lkp@intel.com> wrote:
>
> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/arnd/playground.git randconfig-5.3-rc2
> head:   bfe9aede7372c8310a9bf31963460c9dd11d1f82
> commit: 97919a3ec80e9841c4bbac14a80e8b9d482666d4 [32/347] [SUBMITTED 20190718] reiserfs: fix code unwinding with clang
> config: x86_64-lkp (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
> reproduce:
>         git checkout 97919a3ec80e9841c4bbac14a80e8b9d482666d4
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> fs/reiserfs/namei.o: warning: objtool: entry_points_to_object()+0x117: unreachable instruction
> --
> >> fs/reiserfs/do_balan.o: warning: objtool: get_FEB()+0x55: unreachable instruction
> >> fs/reiserfs/prints.o: warning: objtool: __reiserfs_error()+0x80: unreachable instruction
> >> fs/reiserfs/lbalance.o: warning: objtool: leaf_move_items()+0x210: unreachable instruction
> >> fs/reiserfs/fix_node.o: warning: objtool: create_virtual_node()+0x295: unreachable instruction
> >> fs/reiserfs/inode.o: warning: objtool: reiserfs_update_sd_size()+0x26b: unreachable instruction
> >> fs/reiserfs/ibalance.o: warning: objtool: balance_internal()+0x30d: unreachable instruction
> >> fs/reiserfs/stree.o: warning: objtool: reiserfs_cut_from_item()+0x239: unreachable instruction
> >> fs/reiserfs/tail_conversion.o: warning: objtool: direct2indirect()+0x29c: unreachable instruction
> >> fs/reiserfs/item_ops.o: warning: objtool: direntry_check_left()+0x5d: unreachable instruction
> >> fs/reiserfs/journal.o: warning: objtool: flush_commit_list()+0x552: unreachable instruction

Great fun. The patch I did was my workaround for a related problem with clang,
see below.

Josh, is this warning above something you are interested in? I don't
think it happens in mainline, but it could happen anywhere. I think
the patch below can be dropped once clang is fixed, but I have so far
been unable to build a new compiler for testing.

       Arnd

commit 97919a3ec80e9841c4bbac14a80e8b9d482666d4
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Jul 12 16:19:52 2019 +0200

    [SUBMITTED 20190718] reiserfs: fix code unwinding with clang

    Building reiserfs with clang leads to objtool warnings about a part of the
    unreachable code that may confuse the ORC unwinder:

    fs/reiserfs/ibalance.o: warning: objtool:
balance_internal()+0xe8f: stack state mismatch: cfa1=7+240 cfa2=7+248
    fs/reiserfs/ibalance.o: warning: objtool:
internal_move_pointers_items()+0x36f: stack state mismatch: cfa1=7+152
cfa2=7+144
    fs/reiserfs/lbalance.o: warning: objtool:
leaf_cut_from_buffer()+0x58b: stack state mismatch: cfa1=7+128
cfa2=7+112
    fs/reiserfs/lbalance.o: warning: objtool:
leaf_copy_boundary_item()+0x7a9: stack state mismatch: cfa1=7+104
cfa2=7+96
    fs/reiserfs/lbalance.o: warning: objtool:
leaf_copy_items_entirely()+0x3d2: stack state mismatch: cfa1=7+120
cfa2=7+128
    fs/reiserfs/do_balan.o: warning: objtool: replace_key()+0x158:
stack state mismatch: cfa1=7+40 cfa2=7+56
    fs/reiserfs/do_balan.o: warning: objtool: balance_leaf()+0x2791:
stack state mismatch: cfa1=7+176 cfa2=7+192

    Reword this to use the regular BUG() call directly from the original code
    location, since objtool finds the generated object code more reasonable.

    This will likely get fixed in a future clang release, but in the meantime
    the workaround helps us build cleanly with existing releases.

    Link: https://groups.google.com/d/msgid/clang-built-linux/20190712135755.7qa4wxw3bfmwn5rp%40treble
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/fs/reiserfs/prints.c b/fs/reiserfs/prints.c
index 9fed1c05f1f4..da996eaaebac 100644
--- a/fs/reiserfs/prints.c
+++ b/fs/reiserfs/prints.c
@@ -387,7 +387,6 @@ void __reiserfs_panic(struct super_block *sb,
const char *id,
        else
                printk(KERN_WARNING "REISERFS panic: %s%s%s: %s\n",
                      id ? id : "", id ? " " : "", function, error_buf);
-       BUG();
 }

 void __reiserfs_error(struct super_block *sb, const char *id,
@@ -397,8 +396,10 @@ void __reiserfs_error(struct super_block *sb,
const char *id,

        BUG_ON(sb == NULL);

-       if (reiserfs_error_panic(sb))
+       if (reiserfs_error_panic(sb)) {
                __reiserfs_panic(sb, id, function, error_buf);
+               BUG();
+       }

        if (id && id[0])
                printk(KERN_CRIT "REISERFS error (device %s): %s %s: %s\n",
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index e5ca9ed79e54..f5bd17ee21f6 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -3185,10 +3185,9 @@ void unfix_nodes(struct tree_balance *);

 /* prints.c */
 void __reiserfs_panic(struct super_block *s, const char *id,
-                     const char *function, const char *fmt, ...)
-    __attribute__ ((noreturn));
+                     const char *function, const char *fmt, ...);
 #define reiserfs_panic(s, id, fmt, args...) \
-       __reiserfs_panic(s, id, __func__, fmt, ##args)
+       do { __reiserfs_panic(s, id, __func__, fmt, ##args); BUG(); } while (0)
 void __reiserfs_error(struct super_block *s, const char *id,
                      const char *function, const char *fmt, ...);
 #define reiserfs_error(s, id, fmt, args...) \

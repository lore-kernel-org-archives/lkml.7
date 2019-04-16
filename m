Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0F4C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0B42084B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383413;
	bh=4V7cnJSD3gnK7Wbg0dQcEEa5zF5acruKTNuS50eBVtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YX1aaJYK5bG0WxQy40VTZ8V8iGAIoOVAfsnxQI52R22BpOQnOpgY6o80eq9b92cMy
	 IS6j8S1Gi1jx5/ZEsOs5Gk3lKqh0sRoH7Uze7zARr1Euy1x0t/bUZpO/1rK8IAfnhU
	 kQIcJ361s7nvCw73fsHdP/ZdY2NhqCYm21dypwbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfDPC4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:56:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfDPC4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RmGypS1SiFkM+Leoe9RYaXmjo3WtNtAuPm9+npxzwN0=; b=Ib+xJg6oPykHeIe8DhcrdAgy4t
        tdmgpzUxPW9QUFLucNKX4R7Iw1dacXtRLTF+HY/Eg5Uz5NVYi2n1AyuomfStKYq/4cdcA8mjkLRAu
        XLspqkZAy3UIvG2f6YHYUQX3Dh6Uy8d0vZHzqgq0t2Fz8PqB6Zp9nXPWerHitE0+zosAqu6lgHxNc
        fw64uHz9hShWpd++sE3V3wRmBhTvvlLny1s9l0yq8OQILrPKB/Ghx5mt8GY0hqu7aqVt7rrqIlt6r
        MSzmnb/IuOSIeXFZWiMu94laV0utdYGAVqTz0xqUthz80nqaPFsNiWc08d58dx/oCkhCbUxVlRa6f
        eBVxwkAg==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGz-0007kg-Ie; Tue, 16 Apr 2019 02:56:38 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGn-0001mu-Dn; Mon, 15 Apr 2019 23:56:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org
Subject: [PATCH 20/57] docs: livepatch: convert it to ReST format
Date:   Mon, 15 Apr 2019 23:55:45 -0300
Message-Id: <f8eb5302d14147f5721cce816b1d3500184ce383.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert livepatch documentation to ReST format. The changes
are mostly trivial, as the documents are already on a good
shape. Just a few markup changes are needed for Sphinx to
properly parse the docs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/livepatch/callbacks.txt         |  12 +-
 .../livepatch/cumulative-patches.txt          |  14 +-
 Documentation/livepatch/livepatch.txt         |  56 ++---
 Documentation/livepatch/module-elf-format.txt | 211 ++++++++++--------
 Documentation/livepatch/shadow-vars.txt       |  65 ++++--
 5 files changed, 199 insertions(+), 159 deletions(-)

diff --git a/Documentation/livepatch/callbacks.txt b/Documentation/livepatch/callbacks.txt
index 182e31d4abce..d76d1f0d9fcf 100644
--- a/Documentation/livepatch/callbacks.txt
+++ b/Documentation/livepatch/callbacks.txt
@@ -30,16 +30,20 @@ be patched, irrespective of the target klp_object's current state.
 
 Callbacks can be registered for the following livepatch actions:
 
-  * Pre-patch    - before a klp_object is patched
+  * Pre-patch
+                 - before a klp_object is patched
 
-  * Post-patch   - after a klp_object has been patched and is active
+  * Post-patch
+                 - after a klp_object has been patched and is active
                    across all tasks
 
-  * Pre-unpatch  - before a klp_object is unpatched (ie, patched code is
+  * Pre-unpatch
+                 - before a klp_object is unpatched (ie, patched code is
                    active), used to clean up post-patch callback
                    resources
 
-  * Post-unpatch - after a klp_object has been patched, all code has
+  * Post-unpatch
+                 - after a klp_object has been patched, all code has
                    been restored and no tasks are running patched code,
                    used to cleanup pre-patch callback resources
 
diff --git a/Documentation/livepatch/cumulative-patches.txt b/Documentation/livepatch/cumulative-patches.txt
index 0012808e8d44..1931f318976a 100644
--- a/Documentation/livepatch/cumulative-patches.txt
+++ b/Documentation/livepatch/cumulative-patches.txt
@@ -18,7 +18,7 @@ Usage
 -----
 
 The atomic replace can be enabled by setting "replace" flag in struct klp_patch,
-for example:
+for example::
 
 	static struct klp_patch patch = {
 		.mod = THIS_MODULE,
@@ -49,19 +49,19 @@ Features
 
 The atomic replace allows:
 
-  + Atomically revert some functions in a previous patch while
+  - Atomically revert some functions in a previous patch while
     upgrading other functions.
 
-  + Remove eventual performance impact caused by core redirection
+  - Remove eventual performance impact caused by core redirection
     for functions that are no longer patched.
 
-  + Decrease user confusion about dependencies between livepatches.
+  - Decrease user confusion about dependencies between livepatches.
 
 
 Limitations:
 ------------
 
-  + Once the operation finishes, there is no straightforward way
+  - Once the operation finishes, there is no straightforward way
     to reverse it and restore the replaced patches atomically.
 
     A good practice is to set .replace flag in any released livepatch.
@@ -74,7 +74,7 @@ Limitations:
     only when the transition was not forced.
 
 
-  + Only the (un)patching callbacks from the _new_ cumulative livepatch are
+  - Only the (un)patching callbacks from the _new_ cumulative livepatch are
     executed. Any callbacks from the replaced patches are ignored.
 
     In other words, the cumulative patch is responsible for doing any actions
@@ -93,7 +93,7 @@ Limitations:
     enabled patches were called.
 
 
-  + There is no special handling of shadow variables. Livepatch authors
+  - There is no special handling of shadow variables. Livepatch authors
     must create their own rules how to pass them from one cumulative
     patch to the other. Especially that they should not blindly remove
     them in module_exit() functions.
diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
index 4627b41ff02e..2a1bb3d34b11 100644
--- a/Documentation/livepatch/livepatch.txt
+++ b/Documentation/livepatch/livepatch.txt
@@ -4,22 +4,22 @@ Livepatch
 
 This document outlines basic information about kernel livepatching.
 
-Table of Contents:
+.. Table of Contents:
 
-1. Motivation
-2. Kprobes, Ftrace, Livepatching
-3. Consistency model
-4. Livepatch module
-   4.1. New functions
-   4.2. Metadata
-5. Livepatch life-cycle
-   5.1. Loading
-   5.2. Enabling
-   5.3. Replacing
-   5.4. Disabling
-   5.5. Removing
-6. Sysfs
-7. Limitations
+    1. Motivation
+    2. Kprobes, Ftrace, Livepatching
+    3. Consistency model
+    4. Livepatch module
+       4.1. New functions
+       4.2. Metadata
+    5. Livepatch life-cycle
+       5.1. Loading
+       5.2. Enabling
+       5.3. Replacing
+       5.4. Disabling
+       5.5. Removing
+    6. Sysfs
+    7. Limitations
 
 
 1. Motivation
@@ -40,14 +40,14 @@ There are multiple mechanisms in the Linux kernel that are directly related
 to redirection of code execution; namely: kernel probes, function tracing,
 and livepatching:
 
-  + The kernel probes are the most generic. The code can be redirected by
+  - The kernel probes are the most generic. The code can be redirected by
     putting a breakpoint instruction instead of any instruction.
 
-  + The function tracer calls the code from a predefined location that is
+  - The function tracer calls the code from a predefined location that is
     close to the function entry point. This location is generated by the
     compiler using the '-pg' gcc option.
 
-  + Livepatching typically needs to redirect the code at the very beginning
+  - Livepatching typically needs to redirect the code at the very beginning
     of the function entry before the function parameters or the stack
     are in any way modified.
 
@@ -258,7 +258,7 @@ Documentation/livepatch/module-elf-format.txt for more details.
 The patch is described by several structures that split the information
 into three levels:
 
-  + struct klp_func is defined for each patched function. It describes
+  - struct klp_func is defined for each patched function. It describes
     the relation between the original and the new implementation of a
     particular function.
 
@@ -275,7 +275,7 @@ into three levels:
     only for a particular object ( vmlinux or a kernel module ). Note that
     kallsyms allows for searching symbols according to the object name.
 
-  + struct klp_object defines an array of patched functions (struct
+  - struct klp_object defines an array of patched functions (struct
     klp_func) in the same object. Where the object is either vmlinux
     (NULL) or a module name.
 
@@ -285,7 +285,7 @@ into three levels:
     only when they are available.
 
 
-  + struct klp_patch defines an array of patched objects (struct
+  - struct klp_patch defines an array of patched objects (struct
     klp_object).
 
     This structure handles all patched functions consistently and eventually,
@@ -337,14 +337,16 @@ operation fails.
 Second, livepatch enters into a transition state where tasks are converging
 to the patched state. If an original function is patched for the first
 time, a function specific struct klp_ops is created and an universal
-ftrace handler is registered[*]. This stage is indicated by a value of '1'
+ftrace handler is registered\ [#]_. This stage is indicated by a value of '1'
 in /sys/kernel/livepatch/<name>/transition. For more information about
 this process, see the "Consistency model" section.
 
 Finally, once all tasks have been patched, the 'transition' value changes
 to '0'.
 
-[*] Note that functions might be patched multiple times. The ftrace handler
+.. [#]
+
+    Note that functions might be patched multiple times. The ftrace handler
     is registered only once for a given function. Further patches just add
     an entry to the list (see field `func_stack`) of the struct klp_ops.
     The right implementation is selected by the ftrace handler, see
@@ -421,7 +423,7 @@ See Documentation/ABI/testing/sysfs-kernel-livepatch for more details.
 
 The current Livepatch implementation has several limitations:
 
-  + Only functions that can be traced could be patched.
+  - Only functions that can be traced could be patched.
 
     Livepatch is based on the dynamic ftrace. In particular, functions
     implementing ftrace or the livepatch ftrace handler could not be
@@ -431,7 +433,7 @@ The current Livepatch implementation has several limitations:
 
 
 
-  + Livepatch works reliably only when the dynamic ftrace is located at
+  - Livepatch works reliably only when the dynamic ftrace is located at
     the very beginning of the function.
 
     The function need to be redirected before the stack or the function
@@ -445,7 +447,7 @@ The current Livepatch implementation has several limitations:
     this is handled on the ftrace level.
 
 
-  + Kretprobes using the ftrace framework conflict with the patched
+  - Kretprobes using the ftrace framework conflict with the patched
     functions.
 
     Both kretprobes and livepatches use a ftrace handler that modifies
@@ -453,7 +455,7 @@ The current Livepatch implementation has several limitations:
     is rejected when the handler is already in use by the other.
 
 
-  + Kprobes in the original function are ignored when the code is
+  - Kprobes in the original function are ignored when the code is
     redirected to the new implementation.
 
     There is a work in progress to add warnings about this situation.
diff --git a/Documentation/livepatch/module-elf-format.txt b/Documentation/livepatch/module-elf-format.txt
index f21a5289a09c..7f557c6f6deb 100644
--- a/Documentation/livepatch/module-elf-format.txt
+++ b/Documentation/livepatch/module-elf-format.txt
@@ -4,29 +4,29 @@ Livepatch module Elf format
 
 This document outlines the Elf format requirements that livepatch modules must follow.
 
------------------
-Table of Contents
------------------
-0. Background and motivation
-1. Livepatch modinfo field
-2. Livepatch relocation sections
-   2.1 What are livepatch relocation sections?
-   2.2 Livepatch relocation section format
-       2.2.1 Required flags
-       2.2.2 Required name format
-       2.2.3 Example livepatch relocation section names
-       2.2.4 Example `readelf --sections` output
-       2.2.5 Example `readelf --relocs` output
-3. Livepatch symbols
-   3.1 What are livepatch symbols?
-   3.2 A livepatch module's symbol table
-   3.3 Livepatch symbol format
-       3.3.1 Required flags
-       3.3.2 Required name format
-       3.3.3 Example livepatch symbol names
-       3.3.4 Example `readelf --symbols` output
-4. Architecture-specific sections
-5. Symbol table and Elf section access
+
+.. Table of Contents
+
+   0. Background and motivation
+   1. Livepatch modinfo field
+   2. Livepatch relocation sections
+      2.1 What are livepatch relocation sections?
+      2.2 Livepatch relocation section format
+          2.2.1 Required flags
+          2.2.2 Required name format
+          2.2.3 Example livepatch relocation section names
+          2.2.4 Example `readelf --sections` output
+          2.2.5 Example `readelf --relocs` output
+   3. Livepatch symbols
+      3.1 What are livepatch symbols?
+      3.2 A livepatch module's symbol table
+      3.3 Livepatch symbol format
+          3.3.1 Required flags
+          3.3.2 Required name format
+          3.3.3 Example livepatch symbol names
+          3.3.4 Example `readelf --symbols` output
+   4. Architecture-specific sections
+   5. Symbol table and Elf section access
 
 ----------------------------
 0. Background and motivation
@@ -89,12 +89,15 @@ used by the kernel module loader to identify livepatch modules.
 
 Example modinfo output:
 -----------------------
-% modinfo livepatch-meminfo.ko
-filename:		livepatch-meminfo.ko
-livepatch:		Y
-license:		GPL
-depends:
-vermagic:		4.3.0+ SMP mod_unload
+
+::
+
+	% modinfo livepatch-meminfo.ko
+	filename:		livepatch-meminfo.ko
+	livepatch:		Y
+	license:		GPL
+	depends:
+	vermagic:		4.3.0+ SMP mod_unload
 
 --------------------------------
 2. Livepatch relocation sections
@@ -142,17 +145,18 @@ be copied into memory along with the other SHF_ALLOC sections).
 
 2.2.2 Required name format
 --------------------------
-The name of a livepatch relocation section must conform to the following format:
+The name of a livepatch relocation section must conform to the following
+format::
 
-.klp.rela.objname.section_name
-^        ^^     ^ ^          ^
-|________||_____| |__________|
-   [A]      [B]        [C]
+  .klp.rela.objname.section_name
+  ^        ^^     ^ ^          ^
+  |________||_____| |__________|
+     [A]      [B]        [C]
 
-[A] The relocation section name is prefixed with the string ".klp.rela."
-[B] The name of the object (i.e. "vmlinux" or name of module) to
-    which the relocation section belongs follows immediately after the prefix.
-[C] The actual name of the section to which this relocation section applies.
+  [A] The relocation section name is prefixed with the string ".klp.rela."
+  [B] The name of the object (i.e. "vmlinux" or name of module) to
+      which the relocation section belongs follows immediately after the prefix.
+  [C] The actual name of the section to which this relocation section applies.
 
 2.2.3 Example livepatch relocation section names:
 -------------------------------------------------
@@ -162,6 +166,9 @@ The name of a livepatch relocation section must conform to the following format:
 2.2.4 Example `readelf --sections` output for a patch
 module that patches vmlinux and modules 9p, btrfs, ext4:
 --------------------------------------------------------
+
+::
+
   Section Headers:
   [Nr] Name                          Type                    Address          Off    Size   ES Flg Lk Inf Al
   [ snip ]
@@ -175,23 +182,26 @@ module that patches vmlinux and modules 9p, btrfs, ext4:
   [ snip ]                                       ^                                             ^
                                                  |                                             |
                                                 [*]                                           [*]
-[*] Livepatch relocation sections are SHT_RELA sections but with a few special
-characteristics. Notice that they are marked SHF_ALLOC ("A") so that they will
-not be discarded when the module is loaded into memory, as well as with the
-SHF_RELA_LIVEPATCH flag ("o" - for OS-specific).
+  [*] Livepatch relocation sections are SHT_RELA sections but with a few special
+  characteristics. Notice that they are marked SHF_ALLOC ("A") so that they will
+  not be discarded when the module is loaded into memory, as well as with the
+  SHF_RELA_LIVEPATCH flag ("o" - for OS-specific).
 
 2.2.5 Example `readelf --relocs` output for a patch module:
 -----------------------------------------------------------
-Relocation section '.klp.rela.btrfs.text.btrfs_feature_attr_show' at offset 0x2ba0 contains 4 entries:
-    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
-000000000000001f  0000005e00000002 R_X86_64_PC32          0000000000000000 .klp.sym.vmlinux.printk,0 - 4
-0000000000000028  0000003d0000000b R_X86_64_32S           0000000000000000 .klp.sym.btrfs.btrfs_ktype,0 + 0
-0000000000000036  0000003b00000002 R_X86_64_PC32          0000000000000000 .klp.sym.btrfs.can_modify_feature.isra.3,0 - 4
-000000000000004c  0000004900000002 R_X86_64_PC32          0000000000000000 .klp.sym.vmlinux.snprintf,0 - 4
-[ snip ]                                                                   ^
-                                                                           |
+
+::
+
+  Relocation section '.klp.rela.btrfs.text.btrfs_feature_attr_show' at offset 0x2ba0 contains 4 entries:
+      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
+  000000000000001f  0000005e00000002 R_X86_64_PC32          0000000000000000 .klp.sym.vmlinux.printk,0 - 4
+  0000000000000028  0000003d0000000b R_X86_64_32S           0000000000000000 .klp.sym.btrfs.btrfs_ktype,0 + 0
+  0000000000000036  0000003b00000002 R_X86_64_PC32          0000000000000000 .klp.sym.btrfs.can_modify_feature.isra.3,0 - 4
+  000000000000004c  0000004900000002 R_X86_64_PC32          0000000000000000 .klp.sym.vmlinux.snprintf,0 - 4
+  [ snip ]                                                                   ^
+                                                                             |
                                                                           [*]
-[*] Every symbol referenced by a relocation is a livepatch symbol.
+  [*] Every symbol referenced by a relocation is a livepatch symbol.
 
 --------------------
 3. Livepatch symbols
@@ -231,18 +241,19 @@ relocation section refer to their respective symbols with their symbol indices,
 and the original symbol indices (and thus the symtab ordering) must be
 preserved in order for apply_relocate_add() to find the right symbol.
 
-For example, take this particular rela from a livepatch module:
-Relocation section '.klp.rela.btrfs.text.btrfs_feature_attr_show' at offset 0x2ba0 contains 4 entries:
-    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
-000000000000001f  0000005e00000002 R_X86_64_PC32          0000000000000000 .klp.sym.vmlinux.printk,0 - 4
+For example, take this particular rela from a livepatch module:::
 
-This rela refers to the symbol '.klp.sym.vmlinux.printk,0', and the symbol index is encoded
-in 'Info'. Here its symbol index is 0x5e, which is 94 in decimal, which refers to the
-symbol index 94.
-And in this patch module's corresponding symbol table, symbol index 94 refers to that very symbol:
-[ snip ]
-94: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT OS [0xff20] .klp.sym.vmlinux.printk,0
-[ snip ]
+  Relocation section '.klp.rela.btrfs.text.btrfs_feature_attr_show' at offset 0x2ba0 contains 4 entries:
+      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
+  000000000000001f  0000005e00000002 R_X86_64_PC32          0000000000000000 .klp.sym.vmlinux.printk,0 - 4
+
+  This rela refers to the symbol '.klp.sym.vmlinux.printk,0', and the symbol index is encoded
+  in 'Info'. Here its symbol index is 0x5e, which is 94 in decimal, which refers to the
+  symbol index 94.
+  And in this patch module's corresponding symbol table, symbol index 94 refers to that very symbol:
+  [ snip ]
+  94: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT OS [0xff20] .klp.sym.vmlinux.printk,0
+  [ snip ]
 
 ---------------------------
 3.3 Livepatch symbol format
@@ -256,42 +267,48 @@ See include/uapi/linux/elf.h for the actual definitions.
 
 3.3.2 Required name format
 --------------------------
-Livepatch symbol names must conform to the following format:
+Livepatch symbol names must conform to the following format::
 
-.klp.sym.objname.symbol_name,sympos
-^       ^^     ^ ^         ^ ^
-|_______||_____| |_________| |
-   [A]     [B]       [C]    [D]
+  .klp.sym.objname.symbol_name,sympos
+  ^       ^^     ^ ^         ^ ^
+  |_______||_____| |_________| |
+     [A]     [B]       [C]    [D]
 
-[A] The symbol name is prefixed with the string ".klp.sym."
-[B] The name of the object (i.e. "vmlinux" or name of module) to
-    which the symbol belongs follows immediately after the prefix.
-[C] The actual name of the symbol.
-[D] The position of the symbol in the object (as according to kallsyms)
-    This is used to differentiate duplicate symbols within the same
-    object. The symbol position is expressed numerically (0, 1, 2...).
-    The symbol position of a unique symbol is 0.
+  [A] The symbol name is prefixed with the string ".klp.sym."
+  [B] The name of the object (i.e. "vmlinux" or name of module) to
+      which the symbol belongs follows immediately after the prefix.
+  [C] The actual name of the symbol.
+  [D] The position of the symbol in the object (as according to kallsyms)
+      This is used to differentiate duplicate symbols within the same
+      object. The symbol position is expressed numerically (0, 1, 2...).
+      The symbol position of a unique symbol is 0.
 
 3.3.3 Example livepatch symbol names:
 -------------------------------------
-.klp.sym.vmlinux.snprintf,0
-.klp.sym.vmlinux.printk,0
-.klp.sym.btrfs.btrfs_ktype,0
+
+::
+
+	.klp.sym.vmlinux.snprintf,0
+	.klp.sym.vmlinux.printk,0
+	.klp.sym.btrfs.btrfs_ktype,0
 
 3.3.4 Example `readelf --symbols` output for a patch module:
 ------------------------------------------------------------
-Symbol table '.symtab' contains 127 entries:
-   Num:    Value          Size Type    Bind   Vis     Ndx         Name
-   [ snip ]
-    73: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT OS [0xff20] .klp.sym.vmlinux.snprintf,0
-    74: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT OS [0xff20] .klp.sym.vmlinux.capable,0
-    75: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT OS [0xff20] .klp.sym.vmlinux.find_next_bit,0
-    76: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT OS [0xff20] .klp.sym.vmlinux.si_swapinfo,0
-  [ snip ]                                               ^
-                                                         |
-                                                        [*]
-[*] Note that the 'Ndx' (Section index) for these symbols is SHN_LIVEPATCH (0xff20).
-    "OS" means OS-specific.
+
+::
+
+  Symbol table '.symtab' contains 127 entries:
+     Num:    Value          Size Type    Bind   Vis     Ndx         Name
+     [ snip ]
+      73: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT OS [0xff20] .klp.sym.vmlinux.snprintf,0
+      74: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT OS [0xff20] .klp.sym.vmlinux.capable,0
+      75: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT OS [0xff20] .klp.sym.vmlinux.find_next_bit,0
+      76: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT OS [0xff20] .klp.sym.vmlinux.si_swapinfo,0
+    [ snip ]                                               ^
+                                                           |
+                                                          [*]
+  [*] Note that the 'Ndx' (Section index) for these symbols is SHN_LIVEPATCH (0xff20).
+      "OS" means OS-specific.
 
 ---------------------------------
 4. Architecture-specific sections
@@ -313,11 +330,11 @@ Since apply_relocate_add() requires access to a module's section headers,
 symbol table, and relocation section indices, Elf information is preserved for
 livepatch modules and is made accessible by the module loader through
 module->klp_info, which is a klp_modinfo struct. When a livepatch module loads,
-this struct is filled in by the module loader. Its fields are documented below:
+this struct is filled in by the module loader. Its fields are documented below::
 
-struct klp_modinfo {
-	Elf_Ehdr hdr; /* Elf header */
-	Elf_Shdr *sechdrs; /* Section header table */
-	char *secstrings; /* String table for the section headers */
-	unsigned int symndx; /* The symbol table section index */
-};
+	struct klp_modinfo {
+		Elf_Ehdr hdr; /* Elf header */
+		Elf_Shdr *sechdrs; /* Section header table */
+		char *secstrings; /* String table for the section headers */
+		unsigned int symndx; /* The symbol table section index */
+	};
diff --git a/Documentation/livepatch/shadow-vars.txt b/Documentation/livepatch/shadow-vars.txt
index ecc09a7be5dd..c05715aeafa4 100644
--- a/Documentation/livepatch/shadow-vars.txt
+++ b/Documentation/livepatch/shadow-vars.txt
@@ -27,10 +27,13 @@ A hashtable references all shadow variables.  These references are
 stored and retrieved through a <obj, id> pair.
 
 * The klp_shadow variable data structure encapsulates both tracking
-meta-data and shadow-data:
+  meta-data and shadow-data:
+
   - meta-data
+
     - obj - pointer to parent object
     - id - data identifier
+
   - data[] - storage for shadow data
 
 It is important to note that the klp_shadow_alloc() and
@@ -47,31 +50,43 @@ to do actions that can be done only once when a new variable is allocated.
 
 * klp_shadow_alloc() - allocate and add a new shadow variable
   - search hashtable for <obj, id> pair
+
   - if exists
+
     - WARN and return NULL
+
   - if <obj, id> doesn't already exist
+
     - allocate a new shadow variable
     - initialize the variable using a custom constructor and data when provided
     - add <obj, id> to the global hashtable
 
 * klp_shadow_get_or_alloc() - get existing or alloc a new shadow variable
   - search hashtable for <obj, id> pair
+
   - if exists
+
     - return existing shadow variable
+
   - if <obj, id> doesn't already exist
+
     - allocate a new shadow variable
     - initialize the variable using a custom constructor and data when provided
     - add <obj, id> pair to the global hashtable
 
 * klp_shadow_free() - detach and free a <obj, id> shadow variable
   - find and remove a <obj, id> reference from global hashtable
+
     - if found
+
       - call destructor function if defined
       - free shadow variable
 
 * klp_shadow_free_all() - detach and free all <*, id> shadow variables
   - find and remove any <*, id> references from global hashtable
+
     - if found
+
       - call destructor function if defined
       - free shadow variable
 
@@ -102,12 +117,12 @@ parent "goes live" (ie, any shadow variable get-API requests are made
 for this <obj, id> pair.)
 
 For commit 1d147bfa6429, when a parent sta_info structure is allocated,
-allocate a shadow copy of the ps_lock pointer, then initialize it:
+allocate a shadow copy of the ps_lock pointer, then initialize it::
 
-#define PS_LOCK 1
-struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
-				const u8 *addr, gfp_t gfp)
-{
+  #define PS_LOCK 1
+  struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
+				  const u8 *addr, gfp_t gfp)
+  {
 	struct sta_info *sta;
 	spinlock_t *ps_lock;
 
@@ -123,10 +138,10 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	...
 
 When requiring a ps_lock, query the shadow variable API to retrieve one
-for a specific struct sta_info:
+for a specific struct sta_info:::
 
-void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
-{
+  void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
+  {
 	spinlock_t *ps_lock;
 
 	/* sync with ieee80211_tx_h_unicast_ps_buf */
@@ -136,10 +151,10 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
 	...
 
 When the parent sta_info structure is freed, first free the shadow
-variable:
+variable::
 
-void sta_info_free(struct ieee80211_local *local, struct sta_info *sta)
-{
+  void sta_info_free(struct ieee80211_local *local, struct sta_info *sta)
+  {
 	klp_shadow_free(sta, PS_LOCK, NULL);
 	kfree(sta);
 	...
@@ -155,19 +170,19 @@ these cases, the klp_shadow_get_or_alloc() call can be used to attach
 shadow variables to parents already in-flight.
 
 For commit 1d147bfa6429, a good spot to allocate a shadow spinlock is
-inside ieee80211_sta_ps_deliver_wakeup():
+inside ieee80211_sta_ps_deliver_wakeup()::
 
-int ps_lock_shadow_ctor(void *obj, void *shadow_data, void *ctor_data)
-{
+  int ps_lock_shadow_ctor(void *obj, void *shadow_data, void *ctor_data)
+  {
 	spinlock_t *lock = shadow_data;
 
 	spin_lock_init(lock);
 	return 0;
-}
+  }
 
-#define PS_LOCK 1
-void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
-{
+  #define PS_LOCK 1
+  void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
+  {
 	spinlock_t *ps_lock;
 
 	/* sync with ieee80211_tx_h_unicast_ps_buf */
@@ -200,10 +215,12 @@ suggests how to handle the parent object.
 =============
 
 * https://github.com/dynup/kpatch
-The livepatch implementation is based on the kpatch version of shadow
-variables.
+
+  The livepatch implementation is based on the kpatch version of shadow
+  variables.
 
 * http://files.mkgnu.net/files/dynamos/doc/papers/dynamos_eurosys_07.pdf
-Dynamic and Adaptive Updates of Non-Quiescent Subsystems in Commodity
-Operating System Kernels (Kritis Makris, Kyung Dong Ryu 2007) presented
-a datatype update technique called "shadow data structures".
+
+  Dynamic and Adaptive Updates of Non-Quiescent Subsystems in Commodity
+  Operating System Kernels (Kritis Makris, Kyung Dong Ryu 2007) presented
+  a datatype update technique called "shadow data structures".
-- 
2.20.1


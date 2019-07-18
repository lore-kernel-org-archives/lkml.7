Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4209C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73EF2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BRg5Fs3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391466AbfGRTqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:46:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49275 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403799AbfGRTqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:46:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJkJud2136460
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:46:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJkJud2136460
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563479179;
        bh=WLy4ldt2VHH4CIY/WRDo7mCruY1+viqvfyUQpu1rzjI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BRg5Fs3f0LIQr0V0/niFCYhs0dTjKD0lECzShAqvymHF9OjKldI18Fm380OJur8fz
         leS93rTp9MNZIhtKjr16wO+JBsgqN5ms7vC+g9bsaQmTxHsFFeoBMpf83YRbOZVI8/
         YL8xpoCaNHE+kPCEl6ASC3WlYW68asRAxzWMbg6fjHMeqXEH1WWkhPUkEIPCJof8DD
         NUlczFXhFX6IoIlspaZKmWdlFdsVoR6Zf6eiBNXIKdD6/ME5f2jRAoI3w7P6ETbH32
         RXRv1EJ2AbDCkBzxDircpA7UJ1xs4mwnvhUoUmt7Ogzhq6YLwViLiwX0npY/a+8jrO
         mj3reBqRobI/A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJkIH82136453;
        Thu, 18 Jul 2019 12:46:18 -0700
Date:   Thu, 18 Jul 2019 12:46:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhenzhong Duan <tipbot@zytor.com>
Message-ID: <tip-cd6697b8b8751b65abd7859af55cf06f36b8e716@git.kernel.org>
Cc:     zhenzhong.duan@oracle.com, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, zhenzhong.duan@oracle.com, mingo@kernel.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <1563282957-26898-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1563282957-26898-1-git-send-email-zhenzhong.duan@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot/efi: Remove unused variables
Git-Commit-ID: cd6697b8b8751b65abd7859af55cf06f36b8e716
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cd6697b8b8751b65abd7859af55cf06f36b8e716
Gitweb:     https://git.kernel.org/tip/cd6697b8b8751b65abd7859af55cf06f36b8e716
Author:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
AuthorDate: Tue, 16 Jul 2019 21:15:57 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:41:57 +0200

x86/boot/efi: Remove unused variables

Fix gcc warnings:

arch/x86/boot/compressed/eboot.c: In function 'make_boot_params':
arch/x86/boot/compressed/eboot.c:394:6: warning: unused variable 'i' [-Wunused-variable]
  int i;
      ^
arch/x86/boot/compressed/eboot.c:393:6: warning: unused variable 's1' [-Wunused-variable]
  u8 *s1;
      ^
arch/x86/boot/compressed/eboot.c:392:7: warning: unused variable 's2' [-Wunused-variable]
  u16 *s2;
       ^
arch/x86/boot/compressed/eboot.c:387:8: warning: unused variable 'options' [-Wunused-variable]
  void *options, *handle;
        ^
arch/x86/boot/compressed/eboot.c: In function 'add_e820ext':
arch/x86/boot/compressed/eboot.c:498:16: warning: unused variable 'size' [-Wunused-variable]
  unsigned long size;
                ^
arch/x86/boot/compressed/eboot.c:497:15: warning: unused variable 'status' [-Wunused-variable]
  efi_status_t status;
               ^
arch/x86/boot/compressed/eboot.c: In function 'exit_boot_func':
arch/x86/boot/compressed/eboot.c:681:15: warning: unused variable 'status' [-Wunused-variable]
  efi_status_t status;
               ^
arch/x86/boot/compressed/eboot.c:680:8: warning: unused variable 'nr_desc' [-Wunused-variable]
  __u32 nr_desc;
        ^
arch/x86/boot/compressed/eboot.c: In function 'efi_main':
arch/x86/boot/compressed/eboot.c:750:22: warning: unused variable 'image' [-Wunused-variable]
  efi_loaded_image_t *image;
                      ^

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1563282957-26898-1-git-send-email-zhenzhong.duan@oracle.com

---
 arch/x86/boot/compressed/eboot.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 220d1279d0e2..d6662fdef300 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -384,14 +384,11 @@ struct boot_params *make_boot_params(struct efi_config *c)
 	struct apm_bios_info *bi;
 	struct setup_header *hdr;
 	efi_loaded_image_t *image;
-	void *options, *handle;
+	void *handle;
 	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
 	int options_size = 0;
 	efi_status_t status;
 	char *cmdline_ptr;
-	u16 *s2;
-	u8 *s1;
-	int i;
 	unsigned long ramdisk_addr;
 	unsigned long ramdisk_size;
 
@@ -494,8 +491,6 @@ static void add_e820ext(struct boot_params *params,
 			struct setup_data *e820ext, u32 nr_entries)
 {
 	struct setup_data *data;
-	efi_status_t status;
-	unsigned long size;
 
 	e820ext->type = SETUP_E820_EXT;
 	e820ext->len  = nr_entries * sizeof(struct boot_e820_entry);
@@ -677,8 +672,6 @@ static efi_status_t exit_boot_func(efi_system_table_t *sys_table_arg,
 				   void *priv)
 {
 	const char *signature;
-	__u32 nr_desc;
-	efi_status_t status;
 	struct exit_boot_struct *p = priv;
 
 	signature = efi_is_64bit() ? EFI64_LOADER_SIGNATURE
@@ -747,7 +740,6 @@ struct boot_params *
 efi_main(struct efi_config *c, struct boot_params *boot_params)
 {
 	struct desc_ptr *gdt = NULL;
-	efi_loaded_image_t *image;
 	struct setup_header *hdr = &boot_params->hdr;
 	efi_status_t status;
 	struct desc_struct *desc;

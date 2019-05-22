Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9CFC072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A44621841
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558484065;
	bh=tBUlh7t4ziJIcxmShUGJnmzqdE/W3H7m9a3/sy7TF5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=krlo77zrwBSSbycVp6PeX+ZEsv1pmAqWkBegLZukr1srzlttwTTRPHGPaMra3E3UR
	 9iyl3sXPMM466OPWJAjpw2DeaSKab9r52AfW9psAQaBnmiTzodrjuY9pd8sNCGvssC
	 5947eznG4Gg2F1XBLandk51mI4tzsxJgkgFynXWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfEVAOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 20:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfEVAOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 20:14:24 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C84D921773;
        Wed, 22 May 2019 00:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558484062;
        bh=tBUlh7t4ziJIcxmShUGJnmzqdE/W3H7m9a3/sy7TF5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oLSNEzDmqFj7jLXPvQ3g4WURAHlo6UFEUiGi0QquRUiCvNNoqotBiH3eypXFjfBg9
         zPr8X2BLt365raBut96Q4gD5Q3ucP/BwXvLE+akh3yjczbESjFok9G6DFmgiKZLjWn
         B8cZEIuTJHhGUS0cIITDrCXdx/oBKbKsBSV7naHI=
Date:   Tue, 21 May 2019 17:14:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/spelling.txt: drop "sepc" from the misspelling
 list
Message-Id: <20190521171422.c7ef965e39b27f6142788412@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.9999.1905191108180.10723@viisi.sifive.com>
References: <20190518210037.13674-1-paul.walmsley@sifive.com>
        <201b9ab622b8359225f3a3b673a05047ffce5744.camel@perches.com>
        <alpine.DEB.2.21.9999.1905191108180.10723@viisi.sifive.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 May 2019 11:24:22 -0700 (PDT) Paul Walmsley <paul.walmsley@sifive.com> wrote:

> On Sat, 18 May 2019, Joe Perches wrote:
> 
> > On Sat, 2019-05-18 at 14:00 -0700, Paul Walmsley wrote:
> > > The RISC-V architecture has a register named the "Supervisor Exception
> > > Program Counter", or "sepc".  This abbreviation triggers
> > > checkpatch.pl's misspelling detector, resulting in noise in the
> > > checkpatch output.  The risk that this noise could cause more useful
> > > warnings to be missed seems to outweigh the harm of an occasional
> > > misspelling of "spec".  Thus drop the "sepc" entry from the
> > > misspelling list.
> > 
> > I would agree if you first fixed the existing sepc/spec
> > and sepcific/specific typos.
> > 
> > arch/powerpc/kvm/book3s_xics.c:	 * a pending interrupt, this is a SW error and PAPR sepcifies
> > arch/unicore32/include/mach/regs-gpio.h: * Sepcial Voltage Detect Reg GPIO_GPIR.
> > drivers/scsi/lpfc/lpfc_init.c:		/* Stop any OneConnect device sepcific driver timers */
> > drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c:* OverView:	Read "sepcific bits" from BB register
> > drivers/net/wireless/realtek/rtlwifi/wifi.h:/* Ref: 802.11i sepc D10.0 7.3.2.25.1
> 
> Your agreement shouldn't be needed for the patch I sent.

I always find Joe's input to be very useful.

Here:

From: Andrew Morton <akpm@linux-foundation.org>
Subject: scripts-spellingtxt-drop-sepc-from-the-misspelling-list-fix

fix existing "sepc" instances, per Joe

Cc: Joe Perches <joe@perches.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/kvm/book3s_xics.c                  |    2 +-
 arch/unicore32/include/mach/regs-gpio.h         |    2 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h     |    2 +-
 drivers/scsi/lpfc/lpfc_init.c                   |    2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

--- a/arch/powerpc/kvm/book3s_xics.c~scripts-spellingtxt-drop-sepc-from-the-misspelling-list-fix
+++ a/arch/powerpc/kvm/book3s_xics.c
@@ -830,7 +830,7 @@ static noinline int kvmppc_h_eoi(struct
 	 *
 	 * Note: If EOI is incorrectly used by SW to lower the CPPR
 	 * value (ie more favored), we do not check for rejection of
-	 * a pending interrupt, this is a SW error and PAPR sepcifies
+	 * a pending interrupt, this is a SW error and PAPR specifies
 	 * that we don't have to deal with it.
 	 *
 	 * The sending of an EOI to the ICS is handled after the
--- a/arch/unicore32/include/mach/regs-gpio.h~scripts-spellingtxt-drop-sepc-from-the-misspelling-list-fix
+++ a/arch/unicore32/include/mach/regs-gpio.h
@@ -32,7 +32,7 @@
  */
 #define GPIO_GEDR	(PKUNITY_GPIO_BASE + 0x0018)
 /*
- * Sepcial Voltage Detect Reg GPIO_GPIR.
+ * Special Voltage Detect Reg GPIO_GPIR.
  */
 #define GPIO_GPIR	(PKUNITY_GPIO_BASE + 0x0020)
 
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h~scripts-spellingtxt-drop-sepc-from-the-misspelling-list-fix
+++ a/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -597,7 +597,7 @@ enum ht_channel_width {
 	HT_CHANNEL_WIDTH_MAX,
 };
 
-/* Ref: 802.11i sepc D10.0 7.3.2.25.1
+/* Ref: 802.11i spec D10.0 7.3.2.25.1
  * Cipher Suites Encryption Algorithms
  */
 enum rt_enc_alg {
--- a/drivers/scsi/lpfc/lpfc_init.c~scripts-spellingtxt-drop-sepc-from-the-misspelling-list-fix
+++ a/drivers/scsi/lpfc/lpfc_init.c
@@ -2963,7 +2963,7 @@ lpfc_stop_hba_timers(struct lpfc_hba *ph
 		del_timer_sync(&phba->fcp_poll_timer);
 		break;
 	case LPFC_PCI_DEV_OC:
-		/* Stop any OneConnect device sepcific driver timers */
+		/* Stop any OneConnect device specific driver timers */
 		lpfc_sli4_stop_fcf_redisc_wait_timer(phba);
 		break;
 	default:
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c~scripts-spellingtxt-drop-sepc-from-the-misspelling-list-fix
+++ a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -45,7 +45,7 @@ static	u32 phy_CalculateBitShift(u32 Bit
 /**
 * Function:	PHY_QueryBBReg
 *
-* OverView:	Read "sepcific bits" from BB register
+* OverView:	Read "specific bits" from BB register
 *
 * Input:
 *		struct adapter *	Adapter,
_


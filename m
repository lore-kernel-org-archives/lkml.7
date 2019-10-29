Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5850BCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA6C20679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfJ2SWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:22:41 -0400
Received: from utopia.booyaka.com ([74.50.51.50]:45992 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJ2SWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:22:40 -0400
Received: (qmail 19504 invoked by uid 1019); 29 Oct 2019 18:22:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Oct 2019 18:22:39 -0000
Date:   Tue, 29 Oct 2019 18:22:39 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Yash Shah <yash.shah@sifive.com>
cc:     "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "sorear2@gmail.com" <sorear2@gmail.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "alex@ghiti.fr" <alex@ghiti.fr>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "Palmer Dabbelt \\( Sifive\\)" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "allison@lohutok.net" <allison@lohutok.net>
Subject: RE: [PATCH v2] RISC-V: Add PCIe I/O BAR memory mapping
In-Reply-To: <CH2PR13MB3368A6E99DAB164A52D2954A8C610@CH2PR13MB3368.namprd13.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.999.1910291822280.15841@utopia.booyaka.com>
References: <1571992163-6811-1-git-send-email-yash.shah@sifive.com> <alpine.DEB.2.21.9999.1910250852420.28076@viisi.sifive.com> <CH2PR13MB3368A6E99DAB164A52D2954A8C610@CH2PR13MB3368.namprd13.prod.outlook.com>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019, Yash Shah wrote:

> > On Fri, 25 Oct 2019, Yash Shah wrote:
> > 
> > > For legacy I/O BARs (non-MMIO BARs) to work correctly on RISC-V Linux,
> > > we need to establish a reserved memory region for them, so that
> > > drivers that wish to use the legacy I/O BARs can issue reads and
> > > writes against a memory region that is mapped to the host PCIe
> > > controller's I/O BAR mapping.
> > >
> > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > 
> > Thanks.  And just to confirm: this is a fix, right?  Without this 
> > patch, legacy PCIe I/O resources won't be accessible on RISC-V?
> 
> Yes, this is a fix.

Thanks, queued for v5.4-rc.


- Paul

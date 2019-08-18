Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D67C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 19:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A7921855
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 19:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfHRTVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 15:21:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44893 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfHRTVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 15:21:02 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzQjc-0002l5-BD; Sun, 18 Aug 2019 21:21:00 +0200
Date:   Sun, 18 Aug 2019 21:20:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?ISO-8859-15?Q?Thomas_Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Doug Covelli <dcovelli@vmware.com>
Subject: Re: [PATCH 1/4] x86/vmware: Update platform detection code for
 VMCALL/VMMCALL hypercalls
In-Reply-To: <20190818143316.4906-2-thomas_os@shipmail.org>
Message-ID: <alpine.DEB.2.21.1908182118260.1923@nanos.tec.linutronix.de>
References: <20190818143316.4906-1-thomas_os@shipmail.org> <20190818143316.4906-2-thomas_os@shipmail.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-739704290-1566156060=:1923"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-739704290-1566156060=:1923
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sun, 18 Aug 2019, Thomas Hellström (VMware) wrote:

> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> Vmware has historically used an "inl" instruction for this, but recent
> hardware versions support using VMCALL/VMMCALL instead, so use this method
> if supported at platform detection time. We explicitly need to code
> separate macro versions since the alternatives self-patching has not
> been performed at platform detection time.
> 
> We also put tighter constraints on the assembly input parameters and update
> the SPDX license info.

Can you please split the license stuff into a separate patch? You know, one
patch one thing. It's documented for a reason.

While at it could you please ask your legal folks whether that custom
license boilerplate can go away as well?

Thanks,

	tglx
--8323329-739704290-1566156060=:1923--

Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D2EC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC07206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387966AbfIEKvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:51:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42419 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbfIEKvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:51:42 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i5pMG-0005iC-Gn; Thu, 05 Sep 2019 12:51:20 +0200
Date:   Thu, 5 Sep 2019 12:51:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even
 if revision is unchanged
In-Reply-To: <20190905072029.GB19246@zn.tnic>
Message-ID: <alpine.DEB.2.21.1909051244250.1902@nanos.tec.linutronix.de>
References: <1567056803-6640-1-git-send-email-ashok.raj@intel.com> <20190829060942.GA1312@zn.tnic> <20190829130213.GA23510@araj-mobl1.jf.intel.com> <20190903164630.GF11641@zn.tnic> <41cee473-321c-2758-032a-ccf0f01359dc@oracle.com> <D8A3D2BD-1FD4-4183-8663-3EF02A6099F3@alien8.de>
 <20190905002132.GA26568@otc-nc-03> <20190905072029.GB19246@zn.tnic>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019, Borislav Petkov wrote:
> On Wed, Sep 04, 2019 at 05:21:32PM -0700, Raj, Ashok wrote:
> > But echo 2 > reload would allow reading a microcode file from 
> > /lib/firmware/intel-ucode/ even if the revision hasn't changed right?
> > 
> > #echo 1 > reload wouldn't load if the revision on disk is same as what's loaded,
> > and we want to permit that with the echo 2 option.
> 
> Then before we continue with this, please specify what the exact
> requirements are. Talk to your microcoders or whoever is going to use
> this and give the exact use cases which should be supported and describe
> them in detail.

Plus I have to ask whether this facility makes any sense outside of
microcode development. If so, then please explain the use case and give
a proper justification why this needs to be in the mainline kernel.

Thanks,

	tglx

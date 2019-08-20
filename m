Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E69C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58D222D6D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbfHTNEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:04:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51911 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTNEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:04:21 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i03o2-0005i5-7l; Tue, 20 Aug 2019 15:04:10 +0200
Date:   Tue, 20 Aug 2019 15:04:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Rahul Tanwar <rahul.tanwar@linux.intel.com>, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, tony.luck@intel.com, x86@kernel.org,
        andriy.shevchenko@intel.com, alan@linux.intel.com,
        ricardo.neri-calderon@linux.intel.com, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
Subject: Re: [PATCH v2 2/3] x86/cpu: Add new Intel Atom CPU model name
In-Reply-To: <20190820122233.GN2332@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1908201503300.2223@nanos.tec.linutronix.de>
References: <cover.1565940653.git.rahul.tanwar@linux.intel.com> <83345984845d24b6ce97a32bef21cd0bbdffc86d.1565940653.git.rahul.tanwar@linux.intel.com> <20190820122233.GN2332@hirez.programming.kicks-ass.net>
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

On Tue, 20 Aug 2019, Peter Zijlstra wrote:
> On Fri, Aug 16, 2019 at 04:18:58PM +0800, Rahul Tanwar wrote:
> > Add a new variant of Intel Atom Airmont CPU model.
> > 
> > Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> > ---
> >  arch/x86/include/asm/intel-family.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> > index 0278aa66ef62..cbbb8250370f 100644
> > --- a/arch/x86/include/asm/intel-family.h
> > +++ b/arch/x86/include/asm/intel-family.h
> > @@ -73,6 +73,7 @@
> >  
> >  #define INTEL_FAM6_ATOM_AIRMONT		0x4C /* Cherry Trail, Braswell */
> >  #define INTEL_FAM6_ATOM_AIRMONT_MID	0x5A /* Moorefield */
> > +#define INTEL_FAM6_ATOM_AIRMONT_NP	0x75 /* Lightning Mountain */
> 
> What's _NP ?

  Nuked Product

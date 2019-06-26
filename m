Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C593DC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C67216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfFZTXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:23:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50184 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfFZTXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 15:23:16 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgDVf-0004JZ-MD; Wed, 26 Jun 2019 21:23:11 +0200
Date:   Wed, 26 Jun 2019 21:23:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Raslan, KarimAllah" <karahmed@amazon.de>
cc:     "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "ankur.a.arora@oracle.com" <ankur.a.arora@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kernellwp@gmail.com" <kernellwp@gmail.com>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>
Subject: Re: cputime takes cstate into consideration
In-Reply-To: <1561575536.25880.10.camel@amazon.de>
Message-ID: <alpine.DEB.2.21.1906262119430.32342@nanos.tec.linutronix.de>
References: <CANRm+Cyge6viybs63pt7W-cRdntx+wfyOq5EWE2qmEQ71SzMHg@mail.gmail.com>  <alpine.DEB.2.21.1906261211410.32342@nanos.tec.linutronix.de>  <20190626145413.GE6753@char.us.oracle.com> <1561575536.25880.10.camel@amazon.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-836335723-1561576991=:32342"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-836335723-1561576991=:32342
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 26 Jun 2019, Raslan, KarimAllah wrote:
> On Wed, 2019-06-26 at 10:54 -0400, Konrad Rzeszutek Wilk wrote:
> > There were some ideas that Ankur (CC-ed) mentioned to me of using the perf
> > counters (in the host) to sample the guest and construct a better
> > accounting idea of what the guest does. That way the dashboard
> > from the host would not show 100% CPU utilization.
> 
> You can either use the UNHALTED cycles perf-counter or you can use MPERF/APERF 
> MSRs for that. (sorry I got distracted and forgot to send the patch)

Sure, but then you conflict with the other people who fight tooth and nail
over every single performance counter.

Thanks,

	tglx
--8323329-836335723-1561576991=:32342--

Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58310C282CE
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 01:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222C32175B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 01:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfDFBlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 21:41:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfDFBlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 21:41:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7696A37F46;
        Sat,  6 Apr 2019 01:41:03 +0000 (UTC)
Received: from localhost (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CD132CE64;
        Sat,  6 Apr 2019 01:41:00 +0000 (UTC)
Date:   Sat, 6 Apr 2019 09:40:53 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mingo@kernel.org, bp@alien8.de, hpa@zytor.com, dyoung@redhat.com,
        x86@kernel.org
Subject: Re: [PATCH v3 1/3] x86/boot: Add xloadflags bits for 5-level kernel
 checking
Message-ID: <20190406014053.GW7627@MiWiFi-R3L-srv>
References: <20190312103051.18086-1-bhe@redhat.com>
 <20190312103051.18086-2-bhe@redhat.com>
 <alpine.DEB.2.21.1904052220480.1802@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904052220480.1802@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sat, 06 Apr 2019 01:41:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/19 at 10:23pm, Thomas Gleixner wrote:
> On Tue, 12 Mar 2019, Baoquan He wrote:
> 
> > Add two bits XLF_5LEVEL and XLF_5LEVEL_ENABLED for 5-level kernel.
> > Bit XLF_5LEVEL indicates if 5-level related code is contained
> > in this kernel.
> > Bit XLF_5LEVEL_ENABLED indicates if CONFIG_X86_5LEVEL=y is set.
> > 
> > They are being used in later patch to check if kexec/kdump kernel
> > is loaded in right place.
> 
> Only XLF_5LEVEL is checked. So what's the second flag for?

I put the explanation why only XLF_5LEVEL is checked in cover letter.
Will add them in this log.

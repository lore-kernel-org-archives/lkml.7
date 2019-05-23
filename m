Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4611C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B91206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfEWOul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 10:50:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40081 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbfEWOuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:50:40 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hTp3F-0005dE-3h; Thu, 23 May 2019 16:50:37 +0200
Date:   Thu, 23 May 2019 16:50:36 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: Re: 5.1.0-next-20190520 -- emacs segfaults on 32-bit machine Re:
 5.2-rc0.8: emacs segfaults?! x220, with 32-bit userland
Message-ID: <20190523145035.wncfmwem57z2oxb7@linutronix.de>
References: <20190519221700.GA7154@amd>
 <20190520160636.z6fpjiidc2d5ko5g@linutronix.de>
 <20190520231342.GA20835@amd>
 <20190521073240.mikv2ufwyriy4q7r@linutronix.de>
 <20190522183329.GB10003@amd>
 <20190523083724.GA21185@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190523083724.GA21185@amd>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-23 10:37:24 [+0200], Pavel Machek wrote:
> Hi!
Hi,

> > I did not notice any new crashes.
> 
> New crash now; different machine, way -next kernel... and I even have
> a backtrace.

could you please send me (offlist) your .config? Also, what kind of
userland do you run? Something like Debian stable?

> 								Pavel

Sebastian

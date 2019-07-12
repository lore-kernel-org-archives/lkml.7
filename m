Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C1FC742B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6288C205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfGLKdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 06:33:03 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:40135 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbfGLKdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 06:33:02 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud8.xs4all.net with ESMTPSA
        id lsrDhP6COHOZUlsrGhbQVQ; Fri, 12 Jul 2019 12:33:01 +0200
Message-ID: <cec8238bfffa43650b7bd8feb0e9d9c0acdc15b3.camel@tiscali.nl>
Subject: Re: screen freeze with 5.2-rc6 Dell XPS-13 skylake  i915
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        intel-gfx@lists.freedesktop.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 12 Jul 2019 12:32:45 +0200
In-Reply-To: <9a8ed0f8e880e1a7387db00c74a9b71210ce6aff.camel@tiscali.nl>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <156283735757.12757.8954391372130933707@skylake-alporthouse-com>
         <9a8ed0f8e880e1a7387db00c74a9b71210ce6aff.camel@tiscali.nl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLaRbaES6HfwrzMNSFf3CXWwhvICM4kUP0lrUQX2EC2KOFCdmhd99TIO807yAvQL5IL1KDhcislGjxi3g+Wo9W91bdNcXlP4RKJaVQlDTrvx2kBEmgkr
 A6cbPM/5KpT15ST7HsbnQN7fPkqx8NUc8kJwU+P7BBRFcd1qRiAYu7IibvuuYjQMriAQaQGVIx0J0NqmyDqfMoTbYkD4h6l35gudeX0kvPqut95hSQQK2xvi
 pe6ivjWD0ZOjElm+SZCCcVdsHzW/hJ5CLuxFNkO3xW8Mmff+U04/drYmwJz9uNiNWXvXPlUj+CgtW8EWEHzUHg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Bolle schreef op do 11-07-2019 om 13:20 [+0200]:
> Chris Wilson schreef op do 11-07-2019 om 10:29 [+0100]:
> > Temporary workaround would be to set i915.enable_psr=0
> 
> That workaround seems to work for me. Over an hour of uptime without any
> screen freezes.

May or may not be related: 24 hours into that session I had the machine lock
up hard. Screen frozen, no input possible, etc. I had to power cycle it (after
half an hour, behaving very patient).

But the screen freeze that we're focusing on here never occurred during this
session.


Paul Bolle


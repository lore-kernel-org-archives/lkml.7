Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA73C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F75A2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfCMI6m convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:58:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46615 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfCMI6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:58:41 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h3zih-0001oH-1G; Wed, 13 Mar 2019 09:58:39 +0100
Date:   Wed, 13 Mar 2019 09:58:38 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-kbuild@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH 3/3] kvm: don't redefine flags as something else
Message-ID: <20190313085838.4asltgdydrznnkxv@linutronix.de>
References: <20181017170554.18841-1-bigeasy@linutronix.de>
 <20181017170554.18841-4-bigeasy@linutronix.de>
 <4270a987-e88f-11d6-fb27-c2f79009e0f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <4270a987-e88f-11d6-fb27-c2f79009e0f1@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-17 19:06:33 [+0200], Paolo Bonzini wrote:
> On 17/10/2018 19:05, Sebastian Andrzej Siewior wrote:
> > The function irqfd_wakeup() has flags defined as __poll_t and then it
> > has additional flags which is used for irqflags.
> > 
> > Redefine the inner flags variable as iflags so it does not shadow the
> > outer flags.
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> > Cc: kvm@vger.kernel.org
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

this touches only kvm and was acked by a kvm person. What did it miss to
get applied? :)

Sebastian

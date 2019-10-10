Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023F0C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DA2218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbfJJHie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:38:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56049 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733083AbfJJHfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:35:40 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iISz2-0001VR-Uk; Thu, 10 Oct 2019 09:35:36 +0200
Date:   Thu, 10 Oct 2019 09:35:36 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.3 28/68] KVM: x86: Expose XSAVEERPTR to the
 guest
Message-ID: <20191010073536.ga2eb6ovrql53y6m@linutronix.de>
References: <20191009170547.32204-1-sashal@kernel.org>
 <20191009170547.32204-28-sashal@kernel.org>
 <05acd554-dd0a-d7cd-e17c-90627fa0ec67@redhat.com>
 <20191009214048.irolhz4rwfdiqf2e@linutronix.de>
 <7119916d-462e-8ba8-300c-c165d9df045a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7119916d-462e-8ba8-300c-c165d9df045a@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-10 00:50:09 [+0200], Paolo Bonzini wrote:
> > Also, taking advantage of this feature requires changes which just
> > landed in qemu's master branch.
> 
> That's not a big deal, every QEMU supports every kernel and vice versa.

That is correct. My point was that the visibility of this change on
user's side is very limited.

> Paolo

Sebastian

Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417D7C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2095B2084F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfLDPZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:25:44 -0500
Received: from gentwo.org ([3.19.106.255]:46968 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfLDPZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:25:43 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 1134D3EED9; Wed,  4 Dec 2019 15:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 0FDC23EBB9;
        Wed,  4 Dec 2019 15:25:43 +0000 (UTC)
Date:   Wed, 4 Dec 2019 15:25:43 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
In-Reply-To: <20191204132812.GF25242@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1912041524290.18825@www.lameter.com>
References: <20191126121901.GE20912@dhcp22.suse.cz> <alpine.DEB.2.21.1911261632030.9857@www.lameter.com> <20191126165420.GL20912@dhcp22.suse.cz> <alpine.DEB.2.21.1911271535560.16935@www.lameter.com> <20191127162400.GT20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911271625110.17727@www.lameter.com> <20191127174317.GD26807@dhcp22.suse.cz> <20191204132812.GF25242@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2019, Michal Hocko wrote:

> > > Just drop the events may be best. Then we know if someone is using it.
> >
> > I would be worried that a lack of events might be surprising and a
> > potential userspace wouldn't know that something has changed.
>
> It would be great to land with some decision here.

Drop the events. These are internal kernel structures and supporting
notifiers to userspace is a bit unusual.



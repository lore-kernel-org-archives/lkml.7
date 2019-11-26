Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30006C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A502071A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfKZQc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:32:57 -0500
Received: from gentwo.org ([3.19.106.255]:39390 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbfKZQc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:32:56 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 1F2FE3ED43; Tue, 26 Nov 2019 16:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 1E4D83EC49;
        Tue, 26 Nov 2019 16:32:56 +0000 (UTC)
Date:   Tue, 26 Nov 2019 16:32:56 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
In-Reply-To: <20191126121901.GE20912@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1911261632030.9857@www.lameter.com>
References: <20191126121901.GE20912@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019, Michal Hocko wrote:

> Hi,
> I have just learnt about KOBJ_{ADD,REMOVE} sysfs events triggered on
> kmem cache creation/removal when SLUB is configured. This functionality
> goes all the way down to initial SLUB merge. I do not see any references
> in the Documentation explaining what those events are used for and
> whether there are any real users.
>
> Could you shed some more light into this?

I have no idea about what this is. There have been many people who
reworked the sysfs support and this has been the cause for a lot of
breakage over the years.


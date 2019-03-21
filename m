Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8310BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B42F218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfCUN4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:56:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:39276 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727891AbfCUN4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:56:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0CC20AC3F;
        Thu, 21 Mar 2019 13:56:35 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id ADBADE00BF; Thu, 21 Mar 2019 14:56:34 +0100 (CET)
Date:   Thu, 21 Mar 2019 14:56:34 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 00/22] ethtool netlink interface, part 1
Message-ID: <20190321135634.GG29968@unicorn.suse.cz>
References: <cover.1553170807.git.mkubecek@suse.cz>
 <20190321133142.GF29968@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321133142.GF29968@unicorn.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 02:31:42PM +0100, Michal Kubecek wrote:
> I'm sorry, I'll have to resend the series. A comma was missing in the
> headers so that majordomo at vger.kernel.org discarded it. Sorry for the
> noise.

And this message shouldn't have been sent to netdev and LKML lists. :-(

Michal

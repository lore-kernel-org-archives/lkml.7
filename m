Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57965ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4446F214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfJJSFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 14:05:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:36952 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726323AbfJJSFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 14:05:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C276AD6F;
        Thu, 10 Oct 2019 18:05:02 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 8D1D8E378C; Thu, 10 Oct 2019 20:05:01 +0200 (CEST)
Date:   Thu, 10 Oct 2019 20:05:01 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     netdev@vger.kernel.org
Cc:     Jiri Pirko <jiri@resnulli.us>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 10/17] ethtool: provide string sets with
 STRSET_GET request
Message-ID: <20191010180501.GE22163@unicorn.suse.cz>
References: <cover.1570654310.git.mkubecek@suse.cz>
 <62cb4c137ea6cf675671920de901847d1d083db1.1570654310.git.mkubecek@suse.cz>
 <20191010135917.GK2223@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010135917.GK2223@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 03:59:17PM +0200, Jiri Pirko wrote:
> Wed, Oct 09, 2019 at 10:59:30PM CEST, mkubecek@suse.cz wrote:
> 
> [...]
> 
> >+const struct get_request_ops strset_request_ops = {
> 
> I think when var is leaving context of single file, it should have
> prefix:
> ethnl_strset_request_ops

OK

Michal

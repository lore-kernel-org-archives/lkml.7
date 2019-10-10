Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B49FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D4C20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfJJRNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 13:13:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:47952 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726131AbfJJRNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:13:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7B03B061;
        Thu, 10 Oct 2019 17:13:09 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 14DB1E378C; Thu, 10 Oct 2019 19:13:07 +0200 (CEST)
Date:   Thu, 10 Oct 2019 19:13:07 +0200
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
Subject: Re: [PATCH net-next v7 05/17] ethtool: helper functions for netlink
 interface
Message-ID: <20191010171307.GC22163@unicorn.suse.cz>
References: <cover.1570654310.git.mkubecek@suse.cz>
 <061af34c9f34205ed18a126cef9ebe1534de8bc7.1570654310.git.mkubecek@suse.cz>
 <20191010134203.GA22798@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010134203.GA22798@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 03:42:03PM +0200, Jiri Pirko wrote:
> Wed, Oct 09, 2019 at 10:59:15PM CEST, mkubecek@suse.cz wrote:
> 
> [...]
> 
> 
> >+/**
> >+ * ethnl_parse_header() - parse request header
> >+ * @req_info:    structure to put results into
> >+ * @header:      nest attribute with request header
> >+ * @net:         request netns
> >+ * @extack:      netlink extack for error reporting
> >+ * @policy:      netlink attribute policy to validate header; use
> >+ *               @dflt_header_policy (all attributes allowed) if null
> >+ * @require_dev: fail if no device identiified in header
> 
> s/identiified/identified/

Will fix.

Michal

Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB63AC06513
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA1521721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfGBMPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:15:21 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:37532 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBMPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 08:15:21 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hiHgm-0007A3-0S; Tue, 02 Jul 2019 14:15:12 +0200
Message-ID: <97399f90279564e83bb464a66347b386738eaa9c.camel@sipsolutions.net>
Subject: Re: [PATCH net-next v6 02/15] netlink: rename
 nl80211_validate_nested() to nla_validate_nested()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Date:   Tue, 02 Jul 2019 14:15:10 +0200
In-Reply-To: <d0c23ac629c4a0343acc9f09484e078962c55402.1562067622.git.mkubecek@suse.cz>
References: <cover.1562067622.git.mkubecek@suse.cz>
         <d0c23ac629c4a0343acc9f09484e078962c55402.1562067622.git.mkubecek@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-02 at 13:49 +0200, Michal Kubecek wrote:
> Function nl80211_validate_nested() is not specific to nl80211, it's
> a counterpart to nla_validate_nested_deprecated() with strict validation.
> For consistency with other validation and parse functions, rename it to
> nla_validate_nested().

Umm, right, not sure how that happened. Sorry about that.

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes


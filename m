Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469D8C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D10520449
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfEBPaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:30:46 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:59348 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbfEBPal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:30:41 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hMDfQ-00072u-CD; Thu, 02 May 2019 17:30:36 +0200
Message-ID: <5a7361bf2a6d9c33c8dac2d62a36f196a389fdec.camel@sipsolutions.net>
Subject: Re: [PATCH net-next v2 3/3] netlink: add validation of NLA_F_NESTED
 flag
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 02 May 2019 17:30:35 +0200
In-Reply-To: <6b6ead21c5d8436470b82ab40355f6bd7dbbf14b.1556806084.git.mkubecek@suse.cz>
References: <cover.1556806084.git.mkubecek@suse.cz>
         <6b6ead21c5d8436470b82ab40355f6bd7dbbf14b.1556806084.git.mkubecek@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-02 at 16:15 +0200, Michal Kubecek wrote:
> Add new validation flag NL_VALIDATE_NESTED which adds three consistency
> checks of NLA_F_NESTED_FLAG:
> 
>   - the flag is set on attributes with NLA_NESTED{,_ARRAY} policy
>   - the flag is not set on attributes with other policies except NLA_UNSPEC
>   - the flag is set on attribute passed to nla_parse_nested()
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes


Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E45C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F37420675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfEBPHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:07:55 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:58650 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBPHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:07:54 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hMDJO-0006PH-Ow; Thu, 02 May 2019 17:07:50 +0200
Message-ID: <3c683fc0d3ea3d07034366a5fbbd5ed5049d48b9.camel@sipsolutions.net>
Subject: Re: [PATCH net-next 3/3] netlink: add validation of NLA_F_NESTED
 flag
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        David Ahern <dsahern@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 02 May 2019 17:07:49 +0200
In-Reply-To: <20190502131416.GE21672@unicorn.suse.cz>
References: <cover.1556798793.git.mkubecek@suse.cz>
         <75a0887b3eb70005c272685d8ef9a712f37d7a54.1556798793.git.mkubecek@suse.cz>
         <3e8291cb2491e9a1830afdb903ed2c52e9f7475c.camel@sipsolutions.net>
         <20190502131416.GE21672@unicorn.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-02 at 15:14 +0200, Michal Kubecek wrote:
> 
> > > @@ -415,7 +418,8 @@ enum netlink_validation {
> > >  #define NL_VALIDATE_STRICT (NL_VALIDATE_TRAILING |\
> > >  			    NL_VALIDATE_MAXTYPE |\
> > >  			    NL_VALIDATE_UNSPEC |\
> > > -			    NL_VALIDATE_STRICT_ATTRS)
> > > +			    NL_VALIDATE_STRICT_ATTRS |\
> > > +			    NL_VALIDATE_NESTED)
> > 
> > This is fine _right now_, but in general we cannot keep adding here
> > after the next release :-)
> 
> Right, that's why I would like to get this into the same cycle as your
> series.

Yeah, I know you know, just wanted state it again :-)

> How about "NLA_F_NESTED is missing" and "NLA_F_NESTED not expected"?

Looks good to me.

johannes


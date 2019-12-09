Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C89C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FD32068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfLIXVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:21:09 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:46980 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfLIXVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:21:09 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ieSKk-00GuNm-IL; Tue, 10 Dec 2019 00:20:54 +0100
Message-ID: <54d6f040b283ad19e739d3b5a05d249285231c54.camel@sipsolutions.net>
Subject: Re: [PATCH net-next 1/5] rtnetlink: provide permanent hardware
 address in RTM_NEWLINK
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Date:   Tue, 10 Dec 2019 00:20:51 +0100
In-Reply-To: <0f4b780d5dd38109768d863781b0ce6de9ef4fbb.1575920565.git.mkubecek@suse.cz>
References: <cover.1575920565.git.mkubecek@suse.cz>
         <0f4b780d5dd38109768d863781b0ce6de9ef4fbb.1575920565.git.mkubecek@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-09 at 20:55 +0100, Michal Kubecek wrote:
> 
> +	if (memchr_inv(dev->perm_addr, '\0', dev->addr_len) &&

Why not simply !is_zero_ether_addr()?

johannes


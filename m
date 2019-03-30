Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4561BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E30C218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbfC3J4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:56:03 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:37351 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730415AbfC3J4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 05:56:03 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 02EA1100D942C;
        Sat, 30 Mar 2019 10:56:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AED664141A; Sat, 30 Mar 2019 10:56:00 +0100 (CET)
Date:   Sat, 30 Mar 2019 10:56:00 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com
Subject: Re: [PATCH v3 03/36] thunderbolt: Drop duplicated
 get_switch_by_route()
Message-ID: <20190330095600.rv6ksddas35oycbi@wunner.de>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
 <20190328123633.42882-4-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328123633.42882-4-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 03:36:00PM +0300, Mika Westerberg wrote:
> tb_switch_find_by_route() does the same already so use it instead and
> remove duplicated get_switch_by_route().
                               ^^
"at" route (also in subject)

Apart from that,
Reviewed-by: Lukas Wunner <lukas@wunner.de>

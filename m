Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041D8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C137521773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfC1PkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:40:00 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:45331 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727379AbfC1Pjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:39:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D4D2E83777F0;
        Thu, 28 Mar 2019 15:39:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lace26_55fdeea50dc56
X-Filterd-Recvd-Size: 1926
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Mar 2019 15:39:50 +0000 (UTC)
Message-ID: <393f3fa45b3ddeb3f2394e0d1091021b00d9b829.camel@perches.com>
Subject: Re: [PATCH v3 34/36] thunderbolt: Make rest of the logging to
 happen at debug level
From:   Joe Perches <joe@perches.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com, netdev@vger.kernel.org
Date:   Thu, 28 Mar 2019 08:39:49 -0700
In-Reply-To: <20190328123633.42882-35-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
         <20190328123633.42882-35-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-28 at 15:36 +0300, Mika Westerberg wrote:
> Now that the driver can handle every possible tunnel types there is no
> point to log everything as info level so turn these to happen at debug
> level instead.

trivia:

> diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
[]
> @@ -503,8 +503,8 @@ int tb_path_activate(struct tb_path *path)
>  					    & out_mask;
>  		hop.unknown3 = 0;
>  
> -		tb_port_info(path->hops[i].in_port, "Writing hop %d, index %d",
> -			     i, path->hops[i].in_hop_index);
> +		tb_port_dbg(path->hops[i].in_port, "Writing hop %d, index %d",
> +			    i, path->hops[i].in_hop_index);

Appears to miss a '\n' termination



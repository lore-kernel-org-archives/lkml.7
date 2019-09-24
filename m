Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC930C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF792146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441014AbfIXMyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:54:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:35276 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390387AbfIXMyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:54:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BAB31AC10;
        Tue, 24 Sep 2019 12:54:07 +0000 (UTC)
Date:   Tue, 24 Sep 2019 14:54:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 13/13] lib/test_printf: Add tests for %pfw printk
 modifier
Message-ID: <20190924125407.tyn6xp2ed33eot4z@pathway.suse.cz>
References: <20190918133419.7969-1-sakari.ailus@linux.intel.com>
 <20190918133419.7969-14-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918133419.7969-14-sakari.ailus@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-09-18 16:34:19, Sakari Ailus wrote:
> Add a test for the %pfw printk modifier using software nodes.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

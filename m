Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D6EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2D522CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567598850;
	bh=LO+KuFyx089urMF42s3wea4BYxy3M1HgJggGboBhnM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BtSRz8Cbs22SoK4YfYleaCyuBNv/x0813RlRudfVW0lGO+J/YeL/MEDL8HL0Rfxrc
	 DTXtzCj8yVIoDUs/NVEdHOC6NfzYMA60U41W/1VWKSsPoqPFZx/F5iBNmlwPAIFWWl
	 2tyRiLuRal3hBt3DW8+d0H0nwmNw+c3QTLFb5xgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfIDMH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbfIDMH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:07:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B1922CED;
        Wed,  4 Sep 2019 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567598848;
        bh=LO+KuFyx089urMF42s3wea4BYxy3M1HgJggGboBhnM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rdOjQdfUyK6umzkQnXrjyaaktqFhQPVyzj0dTFczYfvW1ZfuH6s4fX8/tZ8Wz28iE
         yoPLg8tPPy168M7dTkkHUZcHnGxQvecKYnsEMQuk3oAAc2wd5ogReW2aKBOZtC/mg7
         WTH82Jh1z+4R0sF6tHIdNuq+b/pN6qt2xwa4BIy0=
Date:   Wed, 4 Sep 2019 14:07:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 1/2] software node: Initialize the return value in
 software_node_to_swnode()
Message-ID: <20190904120725.GA15829@kroah.com>
References: <20190830075156.76873-1-heikki.krogerus@linux.intel.com>
 <20190830075156.76873-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830075156.76873-2-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 10:51:55AM +0300, Heikki Krogerus wrote:
> The software node is searched from a list that may be empty
> when the function is called. This makes sure that the
> function returns NULL even if the list is empty.
> 
> Fixes: 80488a6b1d3c ("software node: Add support for static node descriptors")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

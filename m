Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A708EC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDDE2339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567600633;
	bh=ydyvC97Y82tb+hpGZvPvFO6Yz4FgZTR92ozpA42y3Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=duNJqDb1tI/MRrw4hDb6dJftuPZ7i17RjfVkkuaWX6Ciajlpc52Vrqj1Lulv7EtnQ
	 BllPEDdRfMzUYsRFNdwRs2tbx50VulGkH66aHSlWWCWr3+P0jvxPu0PYcAkqoY+/V5
	 IRaTkx1ba79stov+x30DmhaEjhLcEF8ISDcJdUmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfIDMhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfIDMhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:37:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5F1722CF5;
        Wed,  4 Sep 2019 12:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567600631;
        bh=ydyvC97Y82tb+hpGZvPvFO6Yz4FgZTR92ozpA42y3Uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dnzSotWTFRjD9M0pI6I+Kr2EpB/UNU3A0gih5UX5ISzJv5zCwvPnskWETm0L1wpOG
         jJSoHoaCvGCLfzAHyw6+7ZOsZF1ADolVvD8fzFOfOJuAFqiVdzIY4teQ2EnefSMKUY
         1mEMH4InV0V+Af5Ud7vG6jvB0pvvq0p3wOtibfqo=
Date:   Wed, 4 Sep 2019 14:37:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] software node: Add software_node_find_by_name()
Message-ID: <20190904123708.GA5043@kroah.com>
References: <20190819100724.30051-1-heikki.krogerus@linux.intel.com>
 <20190819100724.30051-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819100724.30051-2-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 01:07:22PM +0300, Heikki Krogerus wrote:
> Function that searches software nodes by node name.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA1CC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3270B22CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567600646;
	bh=tBJwQEq/UpmgGzW3FrJSZmDckP5C+ZhupkSUXyptUHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qlKNC0SME108sbYVmJIc6Iu+ryE9VkMDB+ztE5SMIUEYZYIalh6Tu7GzZSIXCMV/I
	 0bi3kBhnHf38lYEzW0J9iQkJlzj6S51UfUnPaFbil+4R37XCWiRV21P9t0Omn2rGIl
	 IdHRgRpRgloa1sgdoIbbWnc4qqsiOX6kpr8ODjvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfIDMhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfIDMhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:37:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B0CB21883;
        Wed,  4 Sep 2019 12:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567600644;
        bh=tBJwQEq/UpmgGzW3FrJSZmDckP5C+ZhupkSUXyptUHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qs6Ll5qEyM3mi+u/r56W66YyIJnp6PLS5YfD1RmO39M3ajjXDeEQoMfBfCFnD+5Mm
         fb6WKLXFkf5EDAjN7aO0AZYXD0czjnK4Ok/8nxiJ5NDcQMCqRX+obBZqrgT6JU6qX5
         TtmqOw+PyG8f6qOnRl18OCaebD8nwQc9ioYo/IO8=
Date:   Wed, 4 Sep 2019 14:37:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] usb: roles: intel_xhci: Supplying software node
 for the role mux
Message-ID: <20190904123721.GB5043@kroah.com>
References: <20190819100724.30051-1-heikki.krogerus@linux.intel.com>
 <20190819100724.30051-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819100724.30051-3-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 01:07:23PM +0300, Heikki Krogerus wrote:
> The primary purpose for this node will be to allow linking
> the users of the switch to it. The users will be for example
> USB Type-C connectors. By supplying a reference to this
> node in the software nodes representing the USB Type-C
> controllers or connectors, the drivers for those devices can
> access the switch.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

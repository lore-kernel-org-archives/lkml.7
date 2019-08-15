Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE08C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1D12083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565897435;
	bh=dKWh8jmfZtb9cGVg+9db/SthRvT2pJzAMHiFc31VnAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q5nVfMMp1yBOFulWI9wxXcAAFcUcZB7AGuk8TY0g0uTmIYWys2WjVOBMMHD9NfDlt
	 IQUzsbQVu53GtopNP01RXtZvLR2O4kTJgTcQTniOYW3EaHqwwLtBH+9jKkR01xB4JW
	 qI6e9579SNgokX4tgFWdgVt8qDS72FbW7OkPQv40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbfHOTae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 15:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbfHOTae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:30:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92D4120656;
        Thu, 15 Aug 2019 19:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565897433;
        bh=dKWh8jmfZtb9cGVg+9db/SthRvT2pJzAMHiFc31VnAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NyoeaFSpsnePfJ+ltNZesUrBQ6+GEMKOYalUu7+udEsOgcwItoXxfWXsUzGBlqQwY
         gTDD6kQm9zoIJEIleE9Lwe/B4Pex1zRXX4pujKZMAEUwFLXEPv5r1TodjhPZGoU/gy
         dLnJ7ArSHYM2pWTbOUrMXNjqCu+ZNcRX99VP5rZI=
Date:   Thu, 15 Aug 2019 21:30:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] usb: typec: fusb302: Small changes
Message-ID: <20190815193030.GD30437@kroah.com>
References: <20190814132419.39759-1-heikki.krogerus@linux.intel.com>
 <4a97653f-9222-9cbd-1944-e5192775bcb1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a97653f-9222-9cbd-1944-e5192775bcb1@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 07:26:42PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 14-08-19 15:24, Heikki Krogerus wrote:
> > Hi,
> > 
> > This series removes the deprecated fusb302 specific properties, and
> > stops using struct tcpc_config in the driver.
> > 
> > thanks,
> > 
> > Heikki Krogerus (3):
> >    usb: typec: fusb302: Remove unused properties
> >    dt-bindings: usb: fusb302: Remove deprecated properties
> >    usb: typec: fusb302: Always provide fwnode for the port
> 
> I know this series is already in usb-testing, still I thought
> it would be a good idea to test it on my CHT hw with a fusb302
> TypeC controller. So I've just completed testing this and it
> works as advertised:
> 
> So FWIW:
> 
> Tested-by: Hans de Goede <hdegoede@redhat.com>

Thanks, I'll go add this as I can rebase that branch...

greg k-h

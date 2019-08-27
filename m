Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8169CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7D02186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566920628;
	bh=5CBLLXyz5mH+6UkaFr1muXce8BcgOenSUC9ZoiZKHZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AOoVpAW89WaN5uB9n8BHSyiBcBX+wrHcLy5OudZsTiElrV8geBbkNfW9WZSS4ty1B
	 WtMXuZyFaN3ZUjwfm/9a0BHX/dqh2ORFhVgG3zI1pQ7AMVEQniJo4mJnmM4kpBqs+Q
	 er953bvJ6Dv8rDp8/UyI2/+sl3E3mbG+Hr6TF+PM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfH0Pnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfH0Pnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:43:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60B8720578;
        Tue, 27 Aug 2019 15:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566920625;
        bh=5CBLLXyz5mH+6UkaFr1muXce8BcgOenSUC9ZoiZKHZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VUm+QyTCs6wjxwUWE7sioTbZaEwQ24NoCiZ9H40FcsXD4YpEsZMBaQQpYy2d/jdco
         OZ2ZSNWbTkMetqN+IkRVEJZLoRE3dfsctPnJCv+TZXbMOTMwPhxntk83s5GYV87oMx
         nA38C4c6HALcWBvw0G8xraMd62aKyt175ppzSym8=
Date:   Tue, 27 Aug 2019 17:43:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, elder@kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>, yuchao0@huawei.com,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH 1/9] staging: greybus: fix up SPDX comment in .h files
Message-ID: <20190827154343.GE534@kroah.com>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
 <20190825055429.18547-2-gregkh@linuxfoundation.org>
 <20190826055119.4pbmf5ape224giwz@vireshk-i7>
 <20190827075802.GA29204@kroah.com>
 <20190827092036.GA138083@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190827092036.GA138083@architecture4>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 05:20:36PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On Tue, Aug 27, 2019 at 09:58:02AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Aug 26, 2019 at 11:21:19AM +0530, Viresh Kumar wrote:
> > > On 25-08-19, 07:54, Greg Kroah-Hartman wrote:
> > > > When these files originally got an SPDX tag, I used // instead of /* */
> > > > for the .h files.  Fix this up to use // properly.
> > > > 
> > > > Cc: Viresh Kumar <vireshk@kernel.org>
> > > > Cc: Johan Hovold <johan@kernel.org>
> > > > Cc: Alex Elder <elder@kernel.org>
> > > > Cc: greybus-dev@lists.linaro.org
> > > > Cc: devel@driverdev.osuosl.org
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > >  drivers/staging/greybus/firmware.h               | 2 +-
> > > >  drivers/staging/greybus/gb-camera.h              | 2 +-
> > > >  drivers/staging/greybus/gbphy.h                  | 2 +-
> > > >  drivers/staging/greybus/greybus.h                | 2 +-
> > > >  drivers/staging/greybus/greybus_authentication.h | 2 +-
> > > >  drivers/staging/greybus/greybus_firmware.h       | 2 +-
> > > >  drivers/staging/greybus/greybus_manifest.h       | 2 +-
> > > >  drivers/staging/greybus/greybus_protocols.h      | 2 +-
> > > >  drivers/staging/greybus/greybus_trace.h          | 2 +-
> > > >  drivers/staging/greybus/hd.h                     | 2 +-
> > > >  drivers/staging/greybus/interface.h              | 2 +-
> > > >  drivers/staging/greybus/manifest.h               | 2 +-
> > > >  drivers/staging/greybus/module.h                 | 2 +-
> > > >  drivers/staging/greybus/operation.h              | 2 +-
> > > >  drivers/staging/greybus/spilib.h                 | 2 +-
> > > >  drivers/staging/greybus/svc.h                    | 2 +-
> > > >  16 files changed, 16 insertions(+), 16 deletions(-)
> > > 
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > Thanks for all of the acks!
> > 
> > greg k-h
> 
> I found similar issues of graybus when I tested the latest staging-testing
> 
> In file included from <command-line>:0:0:
> ./include/linux/greybus/greybus_protocols.h:45:2: error: unknown type name ‘__le16’
>   __le16 size;  /* Size in bytes of header + payload */
>   ^~~~~~
> ./include/linux/greybus/greybus_protocols.h:46:2: error: unknown type name ‘__le16’
>   __le16 operation_id; /* Operation unique id */
>   ^~~~~~
> ./include/linux/greybus/greybus_protocols.h:47:2: error: unknown type name ‘__u8’
>   __u8 type;  /* E.g GB_I2C_TYPE_* or GB_GPIO_TYPE_* */
>   ^~~~
> ./include/linux/greybus/greybus_protocols.h:48:2: error: unknown type name ‘__u8’
>   __u8 result;  /* Result of request (in responses only) */
>   ^~~~
> ./include/linux/greybus/greybus_protocols.h:49:2: error: unknown type name ‘__u8’
>   __u8 pad[2];  /* must be zero (ignore when read) */
>   ^~~~
> ./include/linux/greybus/greybus_protocols.h:58:2: error: unknown type name ‘__u8’
>   __u8 phase;
>   ^~~~
> ./include/linux/greybus/greybus_protocols.h:88:2: error: unknown type name ‘__u8’
>   __u8 major;
>   ^~~~
> ./include/linux/greybus/greybus_protocols.h:89:2: error: unknown type name ‘__u8’
>   __u8 minor;
>   ^~~~
> ./include/linux/greybus/greybus_protocols.h:93:2: error: unknown type name ‘__u8’
>   __u8 major;
>   ^~~~
> ./include/linux/greybus/greybus_protocols.h:94:2: error: unknown type name ‘__u8’
>   __u8 minor;
>   ^~~~
> ./include/linux/greybus/greybus_protocols.h:98:2: error: unknown type name ‘__u8’
>   __u8 bundle_id;
>   ^~~~
> ./include/linux/greybus/greybus_protocols.h:102:2: error: unknown type name ‘__u8’
>   __u8 major;
>   ^~~~
> ./include/linux/greybus/greybus_protocols.h:103:2: error: unknown type name ‘__u8’
>   __u8 minor;
>   ^~~~
> ./include/linux/greybus/greybus_protocols.h:108:2: error: unknown type name ‘__le16’
>   __le16   size;
>   ^~~~~~
> ./include/linux/greybus/greybus_protocols.h:113:2: error: unknown type name ‘__u8’
>   __u8   data[0];
>   ^~~~
> ./include/linux/greybus/greybus_protocols.h:118:2: error: unknown type name ‘__le16’
>   __le16   cport_id;
>   ^~~~~~
> ./include/linux/greybus/greybus_protocols.h:122:2: error: unknown type name ‘__le16’
>   __le16   cport_id;
> 
> .. and other files...
> 
> Not very sure... but it seems it can be observed with allmodconfig or
> CONFIG_KERNEL_HEADER_TEST=y and fail my compilation...
> Hope that of some help (kind reminder...)

Ah, thank you so much for this, NOW that makes sense why I got that odd
kbuild warning that I could not figure out.

Let me go fix this up, thank you so much.

greg k-h

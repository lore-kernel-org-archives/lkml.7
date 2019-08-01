Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE9CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F852087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564677329;
	bh=e6sXZVWhcL30bK9Q1nGDuXTZOwe9jZ7GI+MDFBv4ruo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m+A1GbPergjGgCep/t6x5KfONBzIeociIOsApi0JsHrwQ0qyqDPHJeBU9v8ii3ESS
	 WRQrkrypWKwXaQ5X4G2Kciuo+2i8x6miKiPbYAmCfjYDru5HMgq4suNtb1odgAwzNn
	 Xzg7s3nN049zXOsDAAxm9SpoaxlA51bc4+e1Ru64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733055AbfHAQf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfHAQf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:35:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BA1C2087E;
        Thu,  1 Aug 2019 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564677327;
        bh=e6sXZVWhcL30bK9Q1nGDuXTZOwe9jZ7GI+MDFBv4ruo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dslqnasiCE1otIWwNnZZh2ArOo2J+A1A5EfOQlonQRn8XX1GGjqWV6AAfNKxwQ8/V
         oHZbXO0dwgOml3c4fLlPniRyUz2/ieweVoXhN6gtJ5na46wAOfg+ufjd3zAnD4qea5
         837F05FXSYTyZvxmfh22hJrTeIlcmGHis2HZpoxc=
Date:   Thu, 1 Aug 2019 18:35:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: Re: [Patch v2 01/10] staging: rtl8723bs: os_dep: Remove function
 _rtw_regdomain_select
Message-ID: <20190801163525.GB8360@kroah.com>
References: <20190731181158.GA9051@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731181158.GA9051@hari-Inspiron-1545>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 11:41:58PM +0530, Hariprasad Kelam wrote:
> This function simply returns &rtw_regdom_rd . So replace this function
> with actual code
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
> v2 - Add patch number

I only received patches 1-6 and 10.  Where did the others go?

And they were not properly "threaded", please use a tool like 'git
send-email' to have that work correctly.

Please fix up and resend them all.

thanks,

greg k-h

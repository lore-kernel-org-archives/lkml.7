Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AE2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8527218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552659572;
	bh=Jol7pRgDHFEQpgVyFbnKIQK74ojmKMDS5euavFS8mYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UdCpKECR4o4jPWJjzhpcsZqm/0m+owwCaVU3urugYTHLrMnFNLQeaYWwAWPZmaE4d
	 IJ3gtz5I+IRh+jwrxz5JCqiG2mW/Z54KBbcdLu3rejZ4YXjL20YvizQZ0FBGBh72tF
	 8cueGwPsHrmhIblbmn6Io9196M3/fU1g9IIcT9pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfCOOTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729063AbfCOOTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 10:19:30 -0400
Received: from localhost (unknown [76.14.1.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D01521872;
        Fri, 15 Mar 2019 14:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552659570;
        bh=Jol7pRgDHFEQpgVyFbnKIQK74ojmKMDS5euavFS8mYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zZdxt0OtbwrPaz7EGlLj79MTRbB9zvPKveaFcNF1abDQXNG1VjSGGn5ALtfiAq8wi
         6NDYTJ+TpzyxepElh3sRj4BRMLaIAJBfJL38/JfTxdOutlgrCBj1BIm1oGPSEkmy52
         2YUp1X8GbmDnetjMexAOxtZyu0f3dQgorroJ1JQc=
Date:   Fri, 15 Mar 2019 07:19:27 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     maowenan <maowenan@huawei.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, vz@mleia.com
Subject: Re: [PATCH serial v3] sc16is7xx: missing unregister/delete driver on
 error in sc16is7xx_init()
Message-ID: <20190315141927.GB29902@kroah.com>
References: <20190311093959.86344-1-maowenan@huawei.com>
 <20190311121918.GD2412@kadam>
 <566a03ba-aae9-3169-5db3-3417d5eb60f9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <566a03ba-aae9-3169-5db3-3417d5eb60f9@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 09:56:07PM +0800, maowenan wrote:
> ping...

For what?  It's the middle of the merge window at the moment, you should
have gotten an email from my scripts saying what happens at this point
in time, right?

greg k-h

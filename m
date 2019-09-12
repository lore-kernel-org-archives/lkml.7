Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44EEECDE20
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F87C214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568281238;
	bh=zTCphQZeLpbw3R7zTeLLwVWbznN1/ZBpnXdvDC2P4+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oghP7/RtATVCPqlpyXZ2tAoPrt8MasaZmLKyIv1sqreO3ByD0OcmIsvhRrMHNWuxd
	 NR1KlptJjq99U0jfVDNraUZqjxnQsmRo/uVIudHIrM7gKP9iTRKpNnksXVBCwSfrAJ
	 O13e5YaMtKWpyV7oP5Fn5ClVi72oimNRazY35pa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbfILJkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:40:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730816AbfILJkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:40:36 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16AC1208C2;
        Thu, 12 Sep 2019 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568281235;
        bh=zTCphQZeLpbw3R7zTeLLwVWbznN1/ZBpnXdvDC2P4+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uD0zLf06xsPldzV8im9O9JMp4cAp4JnGbg7wLvS+Znc7xYSfEgLDZf0IlFPyrHaFa
         vFNA8CT+gzw+koBvnBEXW04+BjN9RERY1XjY9lcKzfTpOSMuADhbl3cZ8F+YMRaFDw
         2mAosroXBqTKkRpI/SoL3TPW7hPkPEvByr2AuAOI=
Date:   Thu, 12 Sep 2019 10:40:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 5.2 19/94] net/rds: Fix info leak in rds6_inc_info_copy()
Message-ID: <20190912094032.GA41139@kroah.com>
References: <20190908121150.420989666@linuxfoundation.org>
 <20190908121150.989665197@linuxfoundation.org>
 <CAFcO6XPJM9gej3N0on-6rdF0CeMu+aBSnyMW5buPde_a7_ViFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFcO6XPJM9gej3N0on-6rdF0CeMu+aBSnyMW5buPde_a7_ViFQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 04:38:25PM +0800, butt3rflyh4ck wrote:
> can the issue assigned a CVE number？please reply on me as soon as possible.
> thank you

As per the kernel documentation, the kernel community does not assign,
or deal with, CVEs numbers at all.  Just go ask for one directly from
MITRE if you really feel you need one (hint, there is no real need...)

thanks,

greg k-h

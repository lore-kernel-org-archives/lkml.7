Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0461C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9100C214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576050297;
	bh=TEMavfYuWOfpHnuG9O9Kor9rb80myVXsQ6n2q6Fkm6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XCF+Mpc7k3ihOmqOJOhKsXHcyNMVDaNIm1+5HLu/OiJsP//Y8mX56v5fBxJUNwf7l
	 eQ4chi/Aa7/pOUokI55805pLvk6RgRNPQO9mYvpZR2nzQHMeU9/1ufaAxjiSJp3ozA
	 jwbstzwn6UIStSqV/rWmxuRYDGShAlFAA6vs3QuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfLKHo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 02:44:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfLKHo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 02:44:56 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3843F20637;
        Wed, 11 Dec 2019 07:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576050295;
        bh=TEMavfYuWOfpHnuG9O9Kor9rb80myVXsQ6n2q6Fkm6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=isSk1otib+05g1fiVCSJ7A37LBOVycM0XDbFPDrZPOJ4Tpd2Ap0x00wO63Qmhty9b
         OVdgEW0C2cWB6F2gYkvPomir9r64dO2OrCJ7HBLxm4wqwiKKBf7O+PO0wgpagYgyhE
         WkLxqE4sTmDbQnOk5h65smy2mGcdXi7NwD5LYSMI=
Date:   Wed, 11 Dec 2019 15:44:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ARM: dts: imx6: rdu2: Add node for UCS1002 USB
 charger chip
Message-ID: <20191211074445.GQ15858@dragon>
References: <20191209165018.21794-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209165018.21794-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 08:50:16AM -0800, Andrey Smirnov wrote:
> Add node for UCS1002 USB charger chip connected to front panel USB and
> replace "regulator-fixed" previously used to control VBUS.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied all, thanks.

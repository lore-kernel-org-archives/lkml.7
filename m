Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB1CC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABA220B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562009927;
	bh=4IKwJ1WBsL4tH5bRrNZzaF7n1f2I42udnm7nY5xRKF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AP4bcdO+By53qlm/yGmqfhO2d1XknJrb5RbrKMvlu1j3vWSqMu5sL2BtDEaapnFL7
	 ouSMloy/eUexN0nKk0sZl5NqsDouilaktZ8Scc1DNq/qEqmDufQ7B7CjveP7ddEC3Z
	 xYVTHno5LmUky8P6jDOE+/Fw9vBAW4goM5ShJXys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfGATip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbfGATip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 15:38:45 -0400
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net [107.207.74.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22DE220B7C;
        Mon,  1 Jul 2019 19:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562009924;
        bh=4IKwJ1WBsL4tH5bRrNZzaF7n1f2I42udnm7nY5xRKF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tcOJHbpidDFMyPLFeORuqWiX8sMfzMaOTRaxilHkZWUxybgZw+EfK5itKSoDRsx3m
         YoPi0BULn205R1+pxx3kVi1t614vzu1RpP3D7efZqzlHuBpMjOhR2LxfKPPrRiLX7b
         0cAQZIVdrL3WyV2v/O5o4Ewh7gTR7EmU6UNF1kko=
Date:   Mon, 1 Jul 2019 14:38:42 -0500
From:   Andy Gross <agross@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] soc: qcom: mdt_loader: Support loading non-split
 images
Message-ID: <20190701193842.GA21238@hector.attlocal.net>
Mail-Followup-To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Sibi Sankar <sibis@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190622012146.19719-1-bjorn.andersson@linaro.org>
 <20190622012146.19719-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622012146.19719-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 06:21:45PM -0700, Bjorn Andersson wrote:
> In some software releases the firmware images are not split up with each
> loadable segment in it's own file. Check the size of the loaded firmware
> to see if it still contains each segment to be loaded, before falling
> back to the split-out segments.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

This looks fine to me.

Acked-by: Andy Gross <agross@kernel.org>

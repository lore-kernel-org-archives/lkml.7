Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF12BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AAE2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556114966;
	bh=Lun9p6FuV69Ra30hBRoQwrG9PHidC6Y76WIWDQTrjwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GrhGghgSvuQQ/soYiy7H5v3vT3RFW4yitDrJIWOktpLEHqbhM03mpO1sGqt3MQLDO
	 CjetbVYWKZ3SjvrG8C1THkY+2ZLpUDFsYi9SP8Vlrug9MouNJRjbiuSwd1cXGRRBtL
	 bPloJ6AoCBGqaT9yQKXt++XYI0+JFE7DkqYPPyOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfDXOJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfDXOJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:09:25 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C9A22077C;
        Wed, 24 Apr 2019 14:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556114964;
        bh=Lun9p6FuV69Ra30hBRoQwrG9PHidC6Y76WIWDQTrjwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YvcPlrG2ZqQ9AMdDkwogLCkVDjFGk/SDHUk2MH1dEBLtFfkuo43gCLWyiqF+v4RNK
         KIyUuEbwAMjb5mbs0qp/j99w3Yp93lEar7X2Plz9WyhxZ5z+vpQRn6jRvhJMbd08AB
         6n1tok6zTLwi4YzVrXwTw26PvpwwDD18aavtIPsQ=
Date:   Wed, 24 Apr 2019 10:09:22 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 5.0 01/66] arm64: dts: rockchip: fix
 rk3328-roc-cc gmac2io tx/rx_delay
Message-ID: <20190424140922.GZ17719@sasha-vm>
References: <20190424135746.22655-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190424135746.22655-1-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about the noise, git-send-email/msmtp barfed on a name with a
comma it tried to add automatically to recipients. I'll fix it up and
resend.

--
Thanks,
Sasha

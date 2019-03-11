Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37657C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000DB2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552325002;
	bh=+A79/Y2nUgSbhOogsfBSNG4+lD3/VZfex2NqOIfQB5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TneItm9AmFmuTxYCJbMR4HF1dJDASL1ww2j7oBRQv+FFAF7b69bOdW6HzFr23V25+
	 x+aFkwjkQ+ZFZyOXItRL2Wj8A3Dyow35FTI/VoBehgCDMjHAxvNxncgq2Nd4Xar4so
	 37TqvUp82W7O7+A9s/KpW4VKRDnnmW+U2vvRaOsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfCKRXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbfCKRXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:23:20 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E29ED20828;
        Mon, 11 Mar 2019 17:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552325000;
        bh=+A79/Y2nUgSbhOogsfBSNG4+lD3/VZfex2NqOIfQB5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WEzTiDiTcD0ziEUM1mFFfpORoV27aGBKR+6OFphJRWdiKZA7df++2OHc2rX86Uzz5
         1q1xsZvoViFZD7VpDXL+iPlaVaOFeoTP17KHaBByFc1HdN+JEPwpYGogAllTP/w3IH
         45RnIcOA6Vkym3nOdrUCiR1dxBiftF3Uic6ih21o=
Date:   Mon, 11 Mar 2019 13:23:18 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        devel@driverdev.osuosl.org, Martijn Coenen <maco@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH AUTOSEL 4.20 36/81] binder: fix
 CONFIG_ANDROID_BINDER_DEVICES
Message-ID: <20190311172318.GH158926@sasha-vm>
References: <20190228150813.10256-1-sashal@kernel.org>
 <20190228150813.10256-36-sashal@kernel.org>
 <20190228152407.GB8481@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190228152407.GB8481@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 04:24:07PM +0100, Greg Kroah-Hartman wrote:
>On Thu, Feb 28, 2019 at 10:07:28AM -0500, Sasha Levin wrote:
>> From: Christian Brauner <christian@brauner.io>
>>
>> [ Upstream commit 793c8232937610ae00bc174b87d7fc324346eaea ]
>>
>> Several users have tried to only rely on binderfs to provide binder devices
>> and set CONFIG_ANDROID_BINDER_DEVICES="" empty. This is a great use-case of
>> binderfs and one that was always intended to work. However, this is
>> currently not possible since setting CONFIG_ANDROID_BINDER_DEVICES="" emtpy
>> will simply panic the kernel:
>
>There is no binderfs on 4.20, so this patch is not needed on anything
>older than 5.0.
>
>Please drop it from your queues.

Heh, I knew binder was there for a while, didn't know binderfs is
something new. Now dropped, thanks!

--
Thanks,
Sasha

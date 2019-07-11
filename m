Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84465C74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520F220838
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562827391;
	bh=PbD+vmI4bolEzqXxV3CbUbl9K6yA4WOQJXUIUJn9wpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EHAm76o5TybsPK90LqbKdjnVCuzt4VWPR/6xXE9G8pi/06c3wWZ5wufSh96nnxpAa
	 YsNjxin0M3/D9lQyyWPrW8S+msCVxSpc7EzYzq4P684ACGqNFXWC3SpVBIY0iZ/Cc/
	 IilRFJIyes4oSF5eHV+d2zPE0wlTTf8aSy6Jv5h0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfGKGnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 02:43:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfGKGnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 02:43:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6B7F20838;
        Thu, 11 Jul 2019 06:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562827388;
        bh=PbD+vmI4bolEzqXxV3CbUbl9K6yA4WOQJXUIUJn9wpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zBxJvMzckpLQjJBAtUURZbYk9Uk2Zi8u1iTyFBrbw30JLwDtd/eeoifomILtKkVp3
         WKmb8cA8lKoltqrAUTxD4mi0SIhVobLgzUWUwoK3acvlEBLwpS5Nr1JW3i5lvRLz5y
         ApQ14ozND+1mDju9O64HlwXtw5s4R6+2+7Vk0xbk=
Date:   Thu, 11 Jul 2019 08:43:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Xiaobo Xie <xiaobo.xie@nxp.com>
Subject: Re: [PATCH AUTOSEL 5.1 08/39] arm64: dts: ls1028a: Fix CPU idle fail.
Message-ID: <20190711064305.GA10089@kroah.com>
References: <20190703021514.17727-1-sashal@kernel.org>
 <20190703021514.17727-8-sashal@kernel.org>
 <DB8PR04MB6826A4A8CE604F2570DC1EA7F1F30@DB8PR04MB6826.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB8PR04MB6826A4A8CE604F2570DC1EA7F1F30@DB8PR04MB6826.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 05:04:24AM +0000, Ran Wang wrote:
> Hi Sasha, 
> 
>     Thanks for helping port this patch to stable.
>     May I know if I can submit other bug fixes which has been accepted by upstream to stable by myself?
>     If yes, where I can find related process for reference?

Sure!, please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html


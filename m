Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46B9C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728452173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564765268;
	bh=G5MFfB3qOMn5gxbxtDF7WDU8ixM0pOe/XrgOFMI6GhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gEf/3f6KW2gGtrdc5uTIUBNi+WiOM4zM3drfgQTunlbpm4IIL/+SUpgu2orHU9wBc
	 4baQIcUbpA1gK9NVLyj/Zq1JAdY1GgsWZWtlWsve0YaKXmtuYqhF4S1g7rzdXEgx8w
	 EPiYNocupg4b3PPtUxgk3wzSutPKteJ5lDn7zuVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403880AbfHBRBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389673AbfHBRBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:01:06 -0400
Received: from localhost (unknown [106.51.106.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D83A20644;
        Fri,  2 Aug 2019 17:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564765266;
        bh=G5MFfB3qOMn5gxbxtDF7WDU8ixM0pOe/XrgOFMI6GhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iftsDOtZDbBY/aOE5Z4zZY9Zk2DsxluNVzmp4CZ0A3964H2M03tWHDDx88nk4Eb3P
         t9ypQwonCUQNRqZ5XeFVBupT3WLs5pXlCdGvWQClFlcpfkT9Y2CgRGtuAdgwp2q8nJ
         iSYj3+/Ozhs/3zRuCqHKCarZ6Jr8rlVhDIdhTbBs=
Date:   Fri, 2 Aug 2019 22:29:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 18/40] soundwire: bus: split handling of Device0
 events
Message-ID: <20190802165952.GV12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-19-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-19-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> Assigning a device number to a Slave will result in additional events
> when it reports its status in a PING frame. There is no point in
> dealing with all the other devices in a loop, this can be done when a
> non-device0 event happens.

Applied, thanks

-- 
~Vinod

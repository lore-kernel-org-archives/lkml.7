Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2553CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781A7204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572901425;
	bh=n3I/GXodjAc2ailEgazvTeiRrg2euShf1ziuoKHX/wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2brcMbGjhJXbhe0QKeCZo4nDza3Cjq49ab35uCPESwKdJgXzK3tpvBura4iFk+BeZ
	 u7sEIkHik1L45G59bk3zIYbRRl8W37btKoEvv/b1i7Ouj4PuWG+kmNTOXYS8/tAUVZ
	 YpOcoOxBOQIXOAk9yx8GLVNmC6MTZ7teP3COljFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfKDVDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:03:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728377AbfKDVDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:03:44 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 321E720717;
        Mon,  4 Nov 2019 21:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572901423;
        bh=n3I/GXodjAc2ailEgazvTeiRrg2euShf1ziuoKHX/wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tgl8ivGyx0ARu3aabpW+8Rb3YzpsH5Fs2BJItwTpzwpxlkxki2CsCMa/DmmEorEDO
         oqUno/dMmbRiHIst7H3QXmDufjlqNKZda+PVz9o09Zza4J+dMDI0P7ixXFiLb7UWWp
         TaUnj+I5rrNmBODqwzF8zdswHqJD89mG2oVKFUv4=
Date:   Mon, 4 Nov 2019 22:03:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] coresight: next v5.4-rc6
Message-ID: <20191104210325.GA2454533@kroah.com>
References: <20191104181251.26732-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104181251.26732-1-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 11:12:37AM -0700, Mathieu Poirier wrote:
> Hi Greg,
> 
> I collected the following for inclusion in the v5.5 kernel cycle.  Please have a
> have a look when time permits.

Time permits now, looks good, all queued up, thanks.

greg k-h

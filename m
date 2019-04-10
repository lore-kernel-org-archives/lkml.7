Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2225EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF642133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="ZyK7gCij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbfDJMzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:55:16 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:49407 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbfDJMzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=fxOd7HbOGapQxlRKGyYwfmfkrz0ePN/Zo7oRuddRoy4=;
        b=ZyK7gCijRqfn3XBQtUuOWmTBq/eXNNBwzxixT1QPcZxr8mPV2wJueW2J8s7dd9ng+mawRCzTsyFpcR+HGoJfaY0tggA3V2n42NJArNf5C5ropsIIMt4naZroGxFsfaY0JDv+1KO53eIeJVsBKdB99q39gYHHUYIYkDpIk6zffKTkX1jPYHIdubuqDNsCiyu2gibQoo6+OJXldunBfy/nd3DDLAEnTN6LmD/RTxgoemRbQi3M0ibOKFK65zRQ2gBAGdpc8K7KDH9PpUdOpxLXFhVsmGOZqOLU2bwnbNcYvWTDXhVXX/UNxEkhLlJW96SeDBYfyS0Ahz2RuepDrq2DGg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:52772 helo=[192.168.10.179])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hECl0-0002MW-Ox; Wed, 10 Apr 2019 14:55:14 +0200
Subject: Re: [PATCH] drm/bochs: use simple display pipe
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20190410074828.10296-1-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <56c866e1-0f86-1db7-b897-c487866c00f6@tronnes.org>
Date:   Wed, 10 Apr 2019 14:55:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410074828.10296-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 10.04.2019 09.48, skrev Gerd Hoffmann:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>

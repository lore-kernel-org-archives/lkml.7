Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31E9C76186
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 00:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92022086D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 00:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564274187;
	bh=3QcKMWyvud9E/WuCoeT08n9lTblApc1uZ21h4kx9PhU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=VW6USSM4Izw3mdAXP96SOVUo7SXCyg2I+MrdpdVVIL+RxexsXpX8uJmHXZFsKnjys
	 OvQ5vwkSj+f/2jd7t0uAApTBmoDDh6kh57onzroxIywpGZ0wJ+XQYlpPX9hTw5ja5k
	 vXbsQ+6H3DQU30AnhWMA9O8tbqCfCB3wMq+VAvFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfG1Ag0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 20:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfG1Ag0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 20:36:26 -0400
Received: from [192.168.0.101] (unknown [180.111.32.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32516205C9;
        Sun, 28 Jul 2019 00:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564274185;
        bh=3QcKMWyvud9E/WuCoeT08n9lTblApc1uZ21h4kx9PhU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rGgP1an4Xkc81fP263JRufM8BgqKjlDC3mlNL3lmt272CzPVdK4B9dyJWB3gSxqBq
         TPkB8mhv9GqJLzn4sNEveW25kMW4/kt2NSjMLJ2CYmkWgYjnvwdRLMLcs29BKyzIXT
         085dg8hYsKwLZUBAzE/J6C1Xc1SmUEMJVJUGd+64=
Subject: Re: [f2fs-dev] [PATCH v4 1/3] fs: Reserve flag for casefolding
To:     Daniel Rosenberg <drosen@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-doc@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
References: <20190723230529.251659-1-drosen@google.com>
 <20190723230529.251659-2-drosen@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <056a12d4-d787-9a3d-9ad4-4d1136b2a197@kernel.org>
Date:   Sun, 28 Jul 2019 08:36:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190723230529.251659-2-drosen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-7-24 7:05, Daniel Rosenberg via Linux-f2fs-devel wrote:
> In preparation for including the casefold feature within f2fs, elevate
> the EXT4_CASEFOLD_FL flag to FS_CASEFOLD_FL.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

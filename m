Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204C9C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E140C2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561538744;
	bh=kno8bvQvi1MLeTP7GxSeJfqducLcm5OuvaJtblvlWyU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2H+CvxQ+bDE8bDQgWVT8xCwREW6MbzGK62PoVcza3jJcDbbhDnsEkDq41fm/ngeMC
	 Pc008R2ga/0wk7Ycaf99CnFLTQO1LfqtRfgfzTdFkclFLLtsuqlX1ZPxlONBuc7hV8
	 mQrhZeeH3kHnEnIz7+ah/ScpPxiqGImgMxSvS+Uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfFZIpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 04:45:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfFZIpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:45:42 -0400
Received: from localhost (unknown [116.247.127.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9E1320B7C;
        Wed, 26 Jun 2019 08:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561538741;
        bh=kno8bvQvi1MLeTP7GxSeJfqducLcm5OuvaJtblvlWyU=;
        h=From:To:Cc:Subject:Date:From;
        b=ATZkx9XkFK4PgNeLjqn5OxpjuaqleNhcrOfDatHsafbhlgOj2xvknqXoWqDEYIpZP
         J2Rll0CyzHMeMzTKZWXBdzFVXbIs1paDljL+l8eo6Y+4N8oGcjfWSEdveJEpdZnXf1
         NKJTuH7BmGrsNX1mfo4IQkigOQVU5fU4UJ/Jj4yg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 0/1] 4.9.184-stable review
Date:   Wed, 26 Jun 2019 16:45:12 +0800
Message-Id: <20190626083606.302057200@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.184-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.184-rc1
X-KernelTest-Deadline: 2019-06-28T08:36+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.184 release.
There are 1 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri 28 Jun 2019 08:35:42 AM UTC.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.184-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.184-rc1

Eric Dumazet <edumazet@google.com>
    tcp: refine memory limit test in tcp_fragment()


-------------

Diffstat:

 Makefile              | 4 ++--
 net/ipv4/tcp_output.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)



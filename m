Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FA2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFDC206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfCJQrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 12:47:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:44209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbfCJQrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 12:47:51 -0400
Received: from obelix.fritz.box ([88.130.110.30]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LfkJC-1gjqoB21z0-00pNzQ for
 <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 17:47:49 +0100
To:     linux-kernel@vger.kernel.org
From:   "rwarsow@gmx.de" <rwarsow@gmx.de>
Subject: PROBLEM: kernel build fails with CONFIG_BPFILTER_UMH=y
Message-ID: <44e23aba-bb8b-e7a0-a10c-e475210a17f7@gmx.de>
Date:   Sun, 10 Mar 2019 17:47:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZDRKZ7n8IqZ5K2wrWcp5Kt6jNzxalKoYAyx37VDqgCwPzYW1G0T
 DefS45cvVdJTstTh8Yxs1P5qLlv6tGBGGMu4hqyqYjsw2jqWILcP+l/CIKxL2ugR/yYj3wu
 15s7VvVCQ1QyRUgfWuGET3F0b667jUgmkodppg+IOzBd9WqtuOn7mFhpwigHPdXCGqAZeAc
 9eaY8xIjVDAON80j50JJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t5yMlZfewVE=:+pD5tynvRr7GSjiWgAazqn
 zcIRjafAx7vT9co0Jng+GwacTYb5Lz9IE0LXBdZeNihlV+hl3e+Kzy2mjx3kSqQ0icIamvs6E
 bs8k/tueGzxsbHN/NSRpKIolaiLGwWB+7ZYiQwFRjfJcrouqAnZ0esZjQpJbns4kVZxKTqfir
 yx7QfJvKQWQuq8odZKyNJwjHD3tqucHj4mgoFjotgxpfZwbLu9w/d5QgixwCt75gkfYnX5qsA
 iD15m4PeGoc6yuRAnNxttuOWovrbScv0XmIOg/R7058n9CNUzdtveXRxWiBoVyXxefJjRmnRw
 Ddl5hGoAy9ciiaJjv6S5PS5qtG+Et39SGO6zPBGQtgsBPlAdYJrLD0ijV5rh20SMluZXTBIJJ
 UfL6YpUqtQw85eWVw3NpcFsVSziTw3tUFto1MvjAY+FCd4xHwl3eUgt+Sy0saEykvxnZ1GlZp
 WDkDW/bri+D1Xz7PZT9ZmkLDPgsQgL6j0VsIss0CeI+JXYLY2v8WAoTBlCvuFRScXn5Mcom5b
 qxU6lQWNDnwsSsNCM07SgFUTiUaY4wDzPYdf1ATD88WKetg3nCn5H/kSzQ/Uwjw3bzGLiO2E0
 3pbK6iThmu9cauCOQrWA+7bDMI/W0eQrrb7a4fODAlBPQUmMXx2ckncve18othl/TiGD1w2fy
 DWRBy8Nvulcxvx7E1GvE2uOF3l8NOmQEY/uZ6dTZubLBRznN3MLAh29VD+PGOVLAk/yDYZ360
 WYvqe8op230Pe3AVbmSgmdN6w17AeeysOobYkINEGf39exP7kWqyqVerIVkoibsm5NErfbtf2
 ym1p4gWpd1ij/PfUc105NLCPbV5fcx5xTipG4xM6BgREnVpkDQT0ReC1U7iFt0nvuEYZkD1hS
 3nzAtuHnKiLThdyRvX2Bgkii3SmOXyjzncTlN/v2kViHW5AwqHc9i2dW6giK29KWVeythu/1V
 TeFIJVHNB3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hallo

care to look into this:

https://bugzilla.kernel.org/show_bug.cgi?id=202681


-- 
bis neulich... ;-)

Ronald

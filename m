Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FC0C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1CD208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfGaRq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:46:29 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57779 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfGaRq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:46:28 -0400
Received: from [192.168.1.110] ([95.117.90.94]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M6YEz-1hzCCh3cVN-006y7N; Wed, 31 Jul 2019 19:46:26 +0200
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Guide on useful helpers
To:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Organization: metux IT consult
Message-ID: <8375db42-c871-e1e6-2b67-4067239c4e54@metux.net>
Date:   Wed, 31 Jul 2019 19:46:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:a62tFPT5ONOY9kUpFjBFiegJzZxgzgmFwru1dL64LNyOV64ctFK
 2RG5uEFEeysPxXJe2AOmegZAuoMpymRmNwxQK4EpBf0QZ9OaQI8liAOa9zW42C/Cq1J0I+Y
 cAn8d1GjwY8WNHyK93ccEojIAd/GeN/aM8uzdtOKyDXGxKqSPzyqFE62w99Omf5uQm0JCzP
 gM8ELi+XSF9yKUgHIdoRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cb00DRCYwAk=:Q0eIVwlrgXZucsLy/XMFpT
 wNSVIDdcOmLEc++h/KRE81tELZ4wrnRBs72hek98pgdVyqPS9B0DlMboRliWLVLvO+gkGgtp7
 hzcvjmonAf5iPH8vRRAcURT05AO7NQJor5GaP/dzcf+9bM0RU3qhvDbdVbQ+aItlbSqL8+OkE
 8qbFwNySH2Z/brFn6aq/DupEq52MgYyEfY9GiwVKUqp8uFvg+uk6ijC13h1QLhRd8pPXxK4TB
 bpNVGpzXfLWH5aHM7y/pdKJ4oD7vXsMMp9FCB1opau2VClWoDiJAh9oMU6a/hYuyTNZEZ3RHT
 wn6LKS0s5C+68+QiLXV3QJGDM4ap2T106pVTxW+wGP2C7mZQDk3Au/ePJj7NtEXnBaemdw3Jn
 QzfSIZXUick1wcVXTb8Ke0U8zl7RrJHeGdirnTzaIaY1pb2eVsNL6+9KJ333J9BuxrZJGat7g
 fVbSPMXF0sNHGfOquc/qRc9seA7gwY7RdhAmkaik/UZO7csWADCqDCyyOOapmwwv2TD0CIkhs
 LO3rYVsYPSjyvJEZwapy5AsRkanJaLQhjNXmxQHlxTrbYeaS+F8SH4/MW2bfwD/JnXqin0OrR
 Zx5fWC55Q9NFoCTGvFixwfmSEFdQRMcu3Ij/LqybPscfl+KEqt0JhPiBfiIP+Gthzb5Bd7BFs
 0W0la8TJpXiU5dSThUxyDPSxvB7GVDjipKibIm+eajD5uWCst8qitmFBd33YnpKzf0n8akv/9
 4L4swP9H/RfBRdu+54FBqbBJ/otgrdjaeTgqj1SwxMoHWwkcHOeBPIL64GU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,


do we already have some guide (or at least a list of) useful helpers
that can/should be used for more compact/maintainable code ?

I sometimes learn about those by accident (eg. watching at patches
floating around, comments on patches by other folks, reading existing
driver code, ...), but haven't found any guide/docs on that yet.

If there isn't any such guide yet, I'll volounteer for starting and
maintaining it.

Note: I certainly don't intent to duplicate (in-code) function
documentation, but instead some collection of useful tips, that can
be quickly read. Maybe it could be kinda FAQ list.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287

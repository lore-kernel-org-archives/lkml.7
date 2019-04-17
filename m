Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0472CC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BB620872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PBIva85n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfDQFcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:32:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:47225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbfDQFcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 01:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555479051;
        bh=7+WfXQw64R1zvNB0W6v+cz/PMmRzdu/Qdst0hjEDOV4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PBIva85niIG3Fa7tPh+h0kz6UvGx6hKC6wYSuGyUfU5m/+5/XP2Tzpj2IvP3C1e3W
         peiBVCqWYcIGpYh3s38GvADd7PIbpnKm0nVzWhh0wM5CGTe8S2NhcT3ik9jW4qlaIz
         5TCmeOQGohCZon12X7ohbKVP/t7npLEtqi98bwPY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [185.53.43.193] ([185.53.43.193]) by web-mail.gmx.net
 (3c-app-gmx-bs70.server.lan [172.19.170.215]) (via HTTP); Wed, 17 Apr 2019
 07:30:51 +0200
MIME-Version: 1.0
Message-ID: <trinity-366430bd-b9d1-487b-80c7-1796b602ca6b-1555479050979@3c-app-gmx-bs70>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "CK Hu" <ck.hu@mediatek.com>
Cc:     "Philipp Zabel" <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        "chunhui dai" <chunhui.dai@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        "Bibby Hsieh" <bibby.hsieh@mediatek.com>
Subject: Aw: Re: [PATCH v1 0/4] make hdmi work on bananapi-r2
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 17 Apr 2019 07:30:51 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <1555470607.16005.12.camel@mtksdaap41>
References: <20190416145848.11932-1-frank-w@public-files.de>
 <1555470607.16005.12.camel@mtksdaap41>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ZNds9e+miH0qpd3ok9hiLuKvUAtZ9934nKCVtrTOnns0/UoZed+yw86DburOAGB1mFKXT
 zD9qslnYRXtsYSnQaK3GMVz1vZa00vAaxgIqsaAe//H2agbIp+gdMcfPx23EUt6RNCzD+kJGZYI3
 FKVikuEKr9OFLStASs2Oki0umH+/YbZtirqi9WdxQf0nnt/2DJaZF5H9HlllxRM36i7ZOrAUYNxp
 eCih2bdlGaJJS/nPWupenIPnXcTqeB8xhickdtXq5jQjDWHr8uNHB/HS7keLLbAVfSPSs5zmt1Pm
 x4=
X-UI-Out-Filterresults: notjunk:1;V03:K0:kxufu53U2WQ=:0Aw2kdMEE/4vMdvyzu9m+Q
 1VRehj7S96gn5IoDbg3FXjRfidKNyeLioAbOQulUTBbKv3d9tfPyqBv90UkL+H8dmPhPM7SVi
 o201DtZVa4sjit6uDq7DSwS7qVBAmyre4eQ482WEeB3B8HVNUn/q8k0QnrEbE2/bpqyfJ95f/
 VKEz8txCJ3PrSvIw9STz5KrV2Jtj5DiCeTNRzgFBOmQdVaC438OF83KvUii1sEJWxgQ+f4npZ
 praR/+j4LJS3JWRXAbp7BJQrUoLWuwF9pWYVUQfPIWHww1daSNLDwjc9lSw6cPHtZQBSCGFFB
 A5qOCVY6xz1sGKGGmEZGmgltghADnSgl8yByvOunNcxbWF0CYT2MsT/trtASjF6QIXPRME69r
 /GlruJuSnGLO0I9UVr96znZa3jtqZHILnuauqB3IIkl9lIlUhrPrwxKl8rfu/LL26ZvNIUj9J
 pWQ0phI4Rw4qeyPYrkbEK3qYuD1WulHD27PGbJYqJn1PwCDgSKAb7fQqbwtLIF1xEzxnP+4PT
 N7U7Lu0Z95DLFBxQMM7j+TzJd4+M8Qn+kedLyPg0vKHfY5/QA5pN+4IhkXKX5FmOyGEIow8Dc
 kfkXQ31rB35+aUfQxZhafqs716kYoHZDd2fVzwnntFXb0B5LYZIbFhUvUZnJtY1ot9Lx1sohm
 BrVY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi CK Hu,

you mean the problematic patch is fix possible_crtcs (4/4) and the others are ok?

can you push the first 3 while working on the last one?

regards Frank

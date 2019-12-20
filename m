Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF28C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 13:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6599C206EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 13:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="aLIDCm0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfLTNaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 08:30:19 -0500
Received: from mout.web.de ([212.227.17.11]:56129 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfLTNaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 08:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576848617;
        bh=cI6AYJUnh8pWd1W0cxEpgJYIwvjTtzuqJraTqNbsfiM=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=aLIDCm0cVTZ8wBBg4sNhXDX0vBSf/8GXPNUCyXF+0coF454voRdeQc+WgYllWEWTP
         4TqHsAm/aJ6lPFWk5jQ1ZfwiLgXH45U3eCayqIIJpGkLf5TEM9tBtwCcRjhwxe8ZhC
         ZAxNY1F7pevzz1eXTRwKltJ+7Ie1OqWl8gURBmoQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.94.196]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEEeC-1iSwHB0Yye-00FVIX; Fri, 20
 Dec 2019 14:30:17 +0100
To:     linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: Improving documentation for programming interfaces
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <350cd156-9080-24fe-c49e-96e758d3ca45@web.de>
Date:   Fri, 20 Dec 2019 14:30:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1BudEKRhl8kLMveIOn15uFBzOJOMQN9WihPu/dckERqp8uzqQtO
 3MNnf/5CIO7g+ON5iwI8/UFMloQi0xwYK2WFkgZo4x8sJxrOVboukj3l2N/VZk5+mvjzzGP
 2XHniE0b5KKCH/qiUt+z8ATRIyaU0EuaWBIbnZifqE1ZZ8KwM0+0ffpaUovCW79vloaRLbM
 evLyZlkj8bRQCMLQwafAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/EZgPWnVHLk=:HHrw+1orFmebAw13DwgnJh
 5Uy8T1nSzfrerVT+o2A54+2cZ+ij2e6s1OGMAvkWGs6xcmagzS6RaBqe+E9WgTjW9y7sG8gfE
 xKByH4rYoBMn4SZwWwzop8Lj5Lm6C4s6GdGZHeMYlMqQzP86rWpwK2DIULtTnbQtR5iRqvK/C
 Y7sw/G0BShFtolobssRjRLNwKbGMJzXI/7J3+kNB12QrtmhnFh+KD3xuIZ4ajr9QmckaARxdl
 XABJ2mDq8TWwb56UnAauGLgk71jCMhbKv61IRgLZqmLL/94TifbRZKmTFLd16tlK+jAjH4WuM
 0VZbPrgO5cSEoG5+4u1FhTlVd1XNuIKWztHK55GmaVD+LRDTk9z4yvPqR1+/knT65U7EXoN8J
 RYORF4uM8BqJHFBvTiAvkBjB8oL366kSs+wv0i/7m+PFL7uftF/jiZ0cbEOqJvqYzPQ9d3Cnm
 bUmBQ54hmuHhlQdxG6CMyemo4snYGI7RaTUgMuWkl8Wl5e3cZmnPm+z4Ost5sBnpRIhEei2yC
 QvolH5z9VCbFhF92xKthBMtcZEp63xAawxE2OIYBtXmRZAQQtrbCsy5e3l8IcDGddF4Xeef2Z
 I81t/ts432Dmy22OB4Ali9ZqrFscl31RIE93diXBAgiLyfyfO+VpE2t4DWdgGD9k0UP94/enr
 4rS1yblM3hYDDRhlptkYyq1WgTspdJfZuepbffNuGIQCjujwYcSHRTUUrLvE9tHxcP/TkFwoD
 Yw12AqzM8aH95qPI7haW6JfZDaFxWfT1uG1TfLZliVTbecoZ/Nmi25lwQsBHuha8aSklJblLW
 m0N+hCydS2rQAIL+IP28V6i6CAkVcCnKeE4IG+sIHR5xb0hoU6ArM+fdz062sD+ADfg+1zmmt
 rhQ1FhnWHEkhuTSM+4dkb/ykKMulizZTFzUxC3BtJH3NdrGH37OKWgO9pM4ZcLMqcpWZM05ar
 Ky279XX8jNVvQr2r4XviLJC7KkcHAihOlXbfveikO7Gkt9juQ+M7pLZc1A58CXFjnrDxJPZaU
 IWdQFWPO/daRP6TCsYEZfc3CNDalG0NywjMGxDKf71ODNQ4JzGtMOGi1mdH3HJ0icVsZ35Q1Z
 wQi9Us+onz7Fs2vlm3w0UwRAekJBaILGa/WiqIusbnpdcGEMyaF7DZUlIm0tQLZrhnlqJKZdE
 dRGOmKvt8+k3wuw0X2En8cBca6wnSfkDc7Ow8LbWwe1skTUp/DmYtlxbvH5yPn5FiYGwaQTXa
 8+1nN0g/Pst0RzImCRRxdpeNMcfkGJJcBUZNKxRomVwDqW+zvRSsiKkerg7U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Linux supports some programming interfaces. Several functions are provided
as usual. Their application documentation is an ongoing development challe=
nge.

Now I would like to clarify possibilities for the specification of desired
information together with data types besides properties which are handled =
by
the programming language =E2=80=9CC=E2=80=9D so far.
It seems that no customised attributes are supported at the moment.
Thus I imagine to specify helpful annotations as macros.

Example:
Some functions allocate resources to which a pointer (or handle) is return=
ed.
I would find it nice then if such a pointer would contain also the backgro=
und
information by which functions the resource should usually be released.

Can it become easier to determine such data?

Regards,
Markus

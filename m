Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF25C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9731D2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfCVRtQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:49:16 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:54161 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfCVRtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:49:15 -0400
Received: from oxbaltgw59.schlund.de ([172.19.246.146]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mr9OA-1gcAcC0ULe-00oJeN; Fri, 22 Mar 2019 18:49:02 +0100
Date:   Fri, 22 Mar 2019 18:49:01 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     mlangsdo@redhat.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, julien.thierry@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, Dave.Martin@arm.com,
        shankerd@codeaurora.org
Message-ID: <1847942978.52169.1553276941024@email.ionos.de>
In-Reply-To: <20190321230557.45107-11-jeremy.linton@arm.com>
References: <20190321230557.45107-1-jeremy.linton@arm.com>
 <20190321230557.45107-11-jeremy.linton@arm.com>
Subject: Re: [PATCH v6 10/10] arm64: enable generic CPU vulnerabilites
 support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev54
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:V9cXfcWT1zNbuMEvzO7wb90rzVHqkQNr46sa64SrlQSp28+oVI7
 FKSrOF4odhmM3S0sW0NM3doirsncd1mptb2JXkppRxA2r3aODGSTcIJYsEPYtogQYV3QnRu
 K5OCzOu1dvVPSGm/ff4qS6QwJ0crVqVRXxL2b11RJgaESpcOCj5MSlFPoelOi2A+MD3fL+j
 EdMSKIfCv8/UEHr3X9cbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bPXS3IwlMoQ=:GLDCH8IAPxDJvRYtbF8tX7
 7O+acKQICUUpZxALE6qcZnRVyqBfhrXaZea9652yaycimrzrchCsBkqVvJPBR22h67pNLh9/t
 fV6+uoBeC5mJT8ENkXEpk+7dONRuNh1sz38qX4XtpAW15tOR8NU13mX5xgYrUMONCO5RDsQ8n
 I2xq7fmksmMzlL5kaQbw5AQ+NIisGxto4L1fk5LOmUpGgGLu0lk3GtvIrDiMSF5ivzx6YENMF
 q022gwY9MJJ9JQHULqEHiiyPnUo16Hfl5S9/JoATr96w77GTT6g5CgFScx9eOVh2iQ30icJ33
 N6Luw7wYo2Bj0tT1gKS6n8nF//wQYqRVssUM85bjsdIoa8HTzqfVjhzd9p0tDZg7JMp0LIMhK
 0/SLWd0qwGNzaDOQE2qHhsLG5xVmjPzzE/lOgAyjgPHOYc917gDB0jJ4BUNOqU7UuwpAYvH7x
 fRRNxCRW0tzckbbXVvSXclyqGcUOEonX69Q0Vl2yUVgpFozHHDYpzIS+v8wD28GmTRtMBwNVO
 pnTg1jqyQl13XyybsKnTubPBnVs3CQUWbO2FGK6s9awgYbZB7s+szyVvmXQcEi+XKKW9rl58N
 aAWVwrsbTszYiSj6zCG5iMT4YmACbObkDE75rQn58mwhH8KS3UvOcHuWt68+sXT8N78bF0s+s
 gV6iPQ0JTmf3q7OjcmySIVjtb2+2Pd5OI+VhkckC23f9Vj/IVYydEbtwi0KNzyyhOEQBxdK8/
 5gBO7w7QBkE+a5DFrhOkehva/VqMg6SkNWRW2MnZT9iG5g4vYAx6/f2G4zo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

> Jeremy Linton <jeremy.linton@arm.com> hat am 22. März 2019 um 00:05 geschrieben:
> 
> 
> From: Mian Yousaf Kaukab <ykaukab@suse.de>
> 
> Enable CPU vulnerabilty show functions for spectre_v1, spectre_v2,
> meltdown and store-bypass.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

FWIW i tested the series on top of today's linux-next with RPi 3B+ and it's still fine.

Stefan

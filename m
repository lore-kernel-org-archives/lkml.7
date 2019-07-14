Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB61EC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 13:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7100F2064A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 13:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="mktyVUHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfGNNs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 09:48:57 -0400
Received: from mr85p00im-zteg06011601.me.com ([17.58.23.186]:53707 "EHLO
        mr85p00im-zteg06011601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728346AbfGNNs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 09:48:56 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jul 2019 09:48:56 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=04042017; t=1563111691;
        bh=mGH0rkznOU4UB4upH67p79dq9ZtFPBSOzAc/ud8naw4=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=mktyVUHAbRRKdB3T6ICbFL8km7rYilXsd1KPyVsZmux1SrEl/Am1ik5hwgvBkVV6N
         3flOTzi+ArQECvDlmzSrpCY2bw7Vr/WyX2QWA4K1P6d/jE96j2sisicB0nStckkQIa
         SoqmOvup32fKRBfaTp0cFDdvJo1Oc5UarfF/GLR7TxH7yYDZi5FZreccMGc3vOjL3l
         ZiwLUq5PDnE7PcBvSQ+moLdmuRZccJiOdV70sHqvuXA6nF5KOgjOL8/9r8bthKXrWi
         FBwVy9NEISOir1AIGTjMI7cBi2zbGgsdgtSVaKdRm8CkvMhybWn6GvWh9BUHBTxL/g
         njPN12NQDlPDw==
Received: from [10.0.1.62] (unknown [162.211.128.122])
        by mr85p00im-zteg06011601.me.com (Postfix) with ESMTPSA id 52E7C92094D;
        Sun, 14 Jul 2019 13:41:31 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] vmw_balloon: Remove Julien from the maintainers list
From:   Julien Freche <julienfreche@icloud.com>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <AF1518AA-309B-466F-ACD2-1CAD04A72716@vmware.com>
Date:   Sun, 14 Jul 2019 07:41:29 -0600
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1F879E1-096A-4C06-87C6-6D00F12F7343@icloud.com>
References: <20190702100519.7464-1-namit@vmware.com> <20190713144920.GA7495@kroah.com> <AF1518AA-309B-466F-ACD2-1CAD04A72716@vmware.com>
To:     Nadav Amit <namit@vmware.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1812120000 definitions=main-1907140172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Jul 14, 2019, at 12:18 AM, Nadav Amit <namit@vmware.com> wrote:

>> On Jul 13, 2019, at 7:49 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.o=
rg> wrote:
>>=20
>>> On Tue, Jul 02, 2019 at 03:05:19AM -0700, Nadav Amit wrote:
>>> Julien will not be a maintainer anymore.
>>>=20
>>> Signed-off-by: Nadav Amit <namit@vmware.com>
>>> ---
>>> MAINTAINERS | 1 -
>>> 1 file changed, 1 deletion(-)
>>>=20
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 01a52fc964da..f85874b1e653 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -16886,7 +16886,6 @@ F:    drivers/vme/
>>> F:    include/linux/vme*
>>>=20
>>> VMWARE BALLOON DRIVER
>>> -M:    Julien Freche <jfreche@vmware.com>
>>=20
>> I need an ack/something from Julien please.
>=20
> Julien, can I please have you Acked-by?
>=20

The change looks good to me, Nadav. Thanks for updating the maintainer list.=


--=20
Julien=20=


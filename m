Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD7FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761A0217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbfDEIqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:46:16 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:40431 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbfDEIqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:46:15 -0400
Received: from [192.168.1.110] ([95.114.101.225]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N4hj5-1gkF7v1egZ-011g81; Fri, 05 Apr 2019 10:46:08 +0200
Subject: Re: [PATCH 1/4] Add support for SUNIX Multi-I/O board
To:     Lee Jones <lee.jones@linaro.org>, Morris Ku <saumah@gmail.com>
Cc:     linux-kernel@vger.kernel.org, morris_ku@sunix.com
References: <20190319120723.3691-1-saumah@gmail.com>
 <20190402061925.GU4187@dell>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <377340b0-1860-6672-ebee-5e73dc1db722@metux.net>
Date:   Fri, 5 Apr 2019 10:46:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190402061925.GU4187@dell>
Content-Type: multipart/mixed;
 boundary="------------F63B3D61A9C83B50EF3AE530"
Content-Language: en-US
X-Provags-ID: V03:K1:PH0BthK/VHNGVo8uAsQBz4ttAxzoS60krfYkwK+Hf3f3JdEsDNQ
 WbnyaFwTELDJhQLls/bEOoMF/7nwxb3obQx7UHwIKnOXC10zWzRIxJktdWezS6kDferh4fV
 Cx41E3lKI49x+FcDow7HJmT2Fwscn6knf/mh4m/o+XBETidM8ZE/fVGquuMot0GC855Nb17
 JgsMzgpJhbxnCX7HSBk2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kvxV2DYHyws=:SRL88y+IrS0r0fCyz4ObPn
 GWf2Zak686s3d7kVsEK/FQitkgiP68HVfe7LdA4l3QtObSmQwF99PD+9o4VBf/IWDK8hJIHPQ
 8+EkGiMWkYyw6vovFUgY2c+lQ78wvyf8fALxw97jwElkcPSjq/i19/tHdlK/Ni+cB11RxX7M0
 44dSmbHmXgD6Ilg/2GX1k8fr7p+e+VjQFibtkVBZ4yEDz3zI9nRYP3PreAadDDdSCcdM/Qj/t
 xfK7XdbAbk/qvnQxhd0BqevuNpiH0YwZyivdls5szTCvix+FPTMv7p18h+WGtvRlwZYTKBzgx
 +lI8mLdEvtGHTzcrQG4tN8C1tSmJIDsAqxqFviE2BueSWLE5YSczPHTtG5vSF5+Ms5ohUmUAg
 80nl6r+KUxkQ4JbvdhwXr6ISHdK4J1dpVhxvNxOCgKDPZie2jyfaHvSpBsrQjEANpM05RTJZF
 9BNwbR62XgFmOaYbNOUHj11+6K4BtQRPfWphN3yLYZ7Cjt8OMHHQCH3ROh/yADwex+DcHFgs8
 w8jedHEl0F0SGX4aQfhYETiVUBZVHCdgWp33cLYGnBog+gMdAnT/rOPhTfrvbsdmkCnoP4sft
 Nd+agbjSR+ivHNkPDDCki0VzdI33qwkQ11nIVa5YyIG+4pQxfeNwlOf1NOq8i6d8++/vhSrVO
 L0TFjkAbecbrcrbX2+YA8BqTR3yd4zkVgM160E1xpEIkhUIMRByhSTNoZkjJwWBFMyYwYbgzs
 Y0K+mjYTaIOjVqiU/zoZ/UaAtwf3jLqB11jtvw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F63B3D61A9C83B50EF3AE530
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 02.04.19 08:19, Lee Jones wrote:

> Please use `git format-patch` and `git send-email` to create and
> submit your patches.  Use the following flags; --annotate, --compose
> and --thread to ensure the patches are sent a) pinned to each other so
> they do not become spread throughout people's inboxes and b) a cover
> letter is provided which should contain a summary of what you are
> trying to achieve.

here's a little script which helps w/ that: it automatically picks
the corresponding maintainers/maillists, you can also pass the usual
git-send-email flags.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287

--------------F63B3D61A9C83B50EF3AE530
Content-Type: text/plain; charset=UTF-8;
 name="git-send-patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="git-send-patch"

IyEvYmluL2Jhc2gKIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAoKWyAteCAi
JEdJVCIgXSAgICAgICB8fCBleHBvcnQgR0lUPWdpdApbIC1kICIkS0VSTkVMU1JDIiBdIHx8
IGV4cG9ydCBLRVJORUxTUkM9LgoKTEtNTD0ibGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZyIKCmNoZWNrX2tzcmMoKSB7CiAgICBpZiBbIC1kICRLRVJORUxTUkMvYXJjaCBdICYmIFwK
ICAgICAgIFsgLWQgJEtFUk5FTFNSQy9ibG9jayBdICYmIFwKICAgICAgIFsgLWQgJEtFUk5F
TFNSQy9pbml0IF0gJiYgXAogICAgICAgWyAtZCAkS0VSTkVMU1JDL2tlcm5lbCBdICYmIFwK
ICAgICAgIFsgLWQgJEtFUk5FTFNSQy9zb3VuZCBdICYmIFwKICAgICAgIFsgLWQgJEtFUk5F
TFNSQy9kcml2ZXJzIF0gJiYgXAogICAgICAgWyAtZCAkS0VSTkVMU1JDL25ldCBdICYmIFwK
ICAgICAgIFsgLWQgJEtFUk5FTFNSQy9pbmNsdWRlIF0gJiYgXAogICAgICAgWyAtZiAkS0VS
TkVMU1JDL0NPUFlJTkcgXSAmJiBcCiAgICAgICBbIC1mICRLRVJORUxTUkMvTUFJTlRBSU5F
UlMgXSAmJiBcCiAgICAgICBbIC1mICRLRVJORUxTUkMvQ1JFRElUUyBdICYmIFwKICAgICAg
IFsgLWYgJEtFUk5FTFNSQy9LY29uZmlnIF0gJiYgXAogICAgICAgWyAtZiAkS0VSTkVMU1JD
L01ha2VmaWxlIF07IHRoZW4KICAgICAgICByZXR1cm4gMAogICAgZWxzZQogICAgICAgIGVj
aG8gIiQwOiBjYW50IGZpbmQgdGhlIGtlcm5lbCBzb3VyY2UgdHJlZS4gcGxlYXNlIGNhbGwg
bWUgZnJvbSB0aGUgdG9wZGlyIiA+JjIKICAgICAgICBleGl0IDEKICAgIGZpCn0KCmNoZWNr
X2tzcmMKCmdldF9maWxlcygpIHsKICAgICRHSVQgZGlmZiAtLW5hbWUtb25seSAiJFJFRiIK
fQoKZ2V0X21haW50YWluZXJzKCkgewogICAgJEtFUk5FTFNSQy9zY3JpcHRzL2dldF9tYWlu
dGFpbmVyLnBsIC0tbSAtLWwgLS1yZW1vdmUtZHVwbGljYXRlcyBgZ2V0X2ZpbGVzYCB8CiAg
ICAgICAgZ3JlcCAtdiAiJExLTUwiIHwgXAogICAgICAgIGdyZXAgLUUgIihtYWludGFpbmVy
fHJldmlld2VyfG9wZW4gbGlzdCkiIHwgXAogICAgICAgIGdyZXAgLW8gJ1tbOmFsbnVtOl0r
XC5cX1wtXSpAW1s6YWxudW06XStcLlxfXC1dKicKfQoKY29uc3RydWN0X3BhcmFtcygpIHsK
ICAgIGVjaG8gLW4gIi0tdG89JExLTUwgIgogICAgZm9yIGEgaW4gJE1BSU5UQUlORVJTOyBk
bwogICAgICAgIGVjaG8gLW4gIi0tY2M9JGEgIgogICAgZG9uZQp9CgppZiBbICEgIiQxIiBd
OyB0aGVuCiAgICBlY2hvICIkMDogbWlzc2luZyBnaXQgcmV2aXNpb24gdG8gc2VuZCBvdXQi
ID4mMgogICAgZWNobyAiIiA+JjIKICAgIGVjaG8gImZvciBleGFtcGxlOiAnSEVBRF4nIGZv
ciBzZW5kaW5nIGp1c3QgdGhlIGxhc3QgcGF0Y2giID4mMgogICAgZWNobyA+JjIKICAgIGVj
aG8gIiQwIDxnaXQtcmVmPiBbPGV4dHJhIHBhcmFtcyBmb3IgZ2l0LXNlbmQtbWFpbD5dIgog
ICAgZXhpdCAxCmZpCgpSRUY9IiQxIgpzaGlmdAoKZWNobyAic2Nhbm5pbmcgZm9yIG1haW50
YWluZXJzIC4uLiIgPiYyCk1BSU5UQUlORVJTPWBnZXRfbWFpbnRhaW5lcnNgCgplY2hvICJz
ZW5kaW5nIG1haWwgLi4uIiA+JjIKJEdJVCBzZW5kLWVtYWlsIGBjb25zdHJ1Y3RfcGFyYW1z
YCAiJFJFRiIgIiRAIgo=
--------------F63B3D61A9C83B50EF3AE530--

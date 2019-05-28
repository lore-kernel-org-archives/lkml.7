Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7B8C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67ABA208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hOJFJNxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfE1S3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:29:24 -0400
Received: from sonic305-8.consmr.mail.bf2.yahoo.com ([74.6.133.47]:46006 "EHLO
        sonic305-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728090AbfE1S3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559068161; bh=avUDVYUBz8auuraFDdoqpBoiAkKyFAKld7cRDhlyRNE=; h=To:Cc:From:Subject:Date:From:Subject; b=hOJFJNxTdWL5Y2/YU3rHbnEl++//lKWcoFhparHwiV3ttMiHJSnQ4rHDDQF1AcHQaT5VNgv7gqlRNOreKOMWd/pCsibUCBNjv+8YKR1JFdcuhBdTUDALTrD+TxsIxYpsheR10NEV15oUKHri1f8NPST+3i8GI27CO20tNzOXnh0nGgUifCCSAA9UGHgWrmGTsVbochWhxnoCk/HSOQtdC2JsdhlGgA7aYVX5TVbcEhu4Bke+DDePWqEwRES5EHwqt3RMTiKW4FvUm2tCo6AsJMFDpM0RCDRrFnTN7i0ClpJ9Qocm3m7RNGr5CUzs+6QMQRviegu9JMsfpXFwfIlQ0g==
X-YMail-OSG: 5FGCjEoVM1lazO9hO8JwOLwwxw_lIDzfdcNs2UdaW.Y0Zy4scqyNWmcOa5NCY5q
 zRBCsOnOPvUA3GRxnvG7ArRmIwj3u5FsIiXFZ3XRtiQE1dUZ5JDb9n2.SiBcsInfwH.SKO0uRf.h
 0WEkgicl4w8Wmx542HkM4FySJZHzx7_JQZw6uxGygFVIuOGbwE4SdV1JnnqNrLAWfKtu9JLDzZmw
 ykWyL2.j80HqkqJYAUpGfqH11YdasXzqTpSR2W8vVhUXbI.T2rYE2QRqNHnJ0b31pCo9bWLY1iNI
 gMh6in1FqVMJ0bU92w4W1yuqeWB6I4aRLZjDVyQJKvRl0LRMu1FhwHf58e_2AmWIU3jZyA8pnOvs
 qmtmMEtEI5g9PZvvdcOx0W2qOYjynvg_PAI7iKJd8qh6ZqiPsMdB2LEqcuaD2U8BHcMcgE2h._6L
 ialzPDjrBGJQblpiXR3UnqI8j1GcfgyH_0gHkCKcpKVCo6ge.sQckJS7EMB59oS1f_tqd3jvEFUe
 AmYyj1QOA7FvYn2gvsbWkGlN6sxe1VaR5cEif4TRk7dLL_wjJjGOStPfBrbiGMp4kM0kORtmtQMh
 ewBYIa5MZZhpi7nnEsx4HXI.0LY_09XSFvrxuoxmZhZ8Adt2EU6ENOvA8YaXCnX5i1oavx_K11fo
 .zPjbyqBLOTKHG1TYpYiVAPvsQ93jfyaIzCSwUVXfXwRpTYPKaEJ3WnTXNh4dBFqT6JYfJQfrkAO
 TS8Zv606BqeccjLB0ZDfcoERlDYw.jaC5a1jvpWBgTU7du.Rmb5D__plOOenAwKh1JhHpdIQ9BiF
 PRc.gmqyYOUkL5oRXehQBNpemkBGtCzxVQPnTZElbd3Z0_hS_y_NEaYTALdeDSK1A7T4u7HbbSDL
 pYul4ptlAEa0BwlUqA5OgkHwcb6.8Hr5LUNSjYRv.6lVDG2OUA_RrdKtH3QR6hDF4D2bOYOgk3yN
 0aKuAjwFU1mEyqCLU_rFCyIOy7kfrpmqEFYW2i90_6lSchjwZ7E_EvFACoXg_4lGI7Q6AYuxuxgI
 5X_EZgNHdFzyF6HzNbk0lJJOuFV_cKRWAaGP40MMTiNtxEfCQPZIK6toqa6OS_cfZz4qHIs9RJxC
 Hm_4tn0IpMNaTrAbYIYTTmjVKxpdhx._UlKKSqdvAJ1HI9taM8aFtgw1HJVlyjXFXZuXuLA_g318
 HWvuiK0mkrtAgJgJxS3MNEJ_wb_ag8vmWvGXzHJXN3WOMuKLJj2Lz6uJ0AM5BeThVY99cSa_p1if
 _Uu.FlrBbzKIsNn4Kdy2NPduwnGlXH6fpTz4FUFyNzIh2VfJNFGUk7as921RB
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Tue, 28 May 2019 18:29:21 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp431.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8e17aa1aeb297b55fa30879c9b46d361;
          Tue, 28 May 2019 18:29:19 +0000 (UTC)
To:     James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>, casey@schaufler-ca.com,
        LKML <linux-kernel@vger.kernel.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [PULL] Smack: Restore the smackfsdef mount option
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <6889f4f9-4ae0-8a92-a2fc-04151ad8ed9f@schaufler-ca.com>
Date:   Tue, 28 May 2019 11:29:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James, this is a repair for a regression introduced in 5.1.
It should be pulled for 5.2 and added to 5.1.

The following changes since commit 619ae03e922b65a1a5d4269ceae1e9e13a058d=
6b:

  Smack: Fix kbuild reported build error (2019-04-30 14:13:32 -0700)

are available in the git repository at:

  https://github.com/cschaufler/next-smack.git smack-for-5.2-b

for you to fetch changes up to a5765ce797070d046dc53ccceeb0ed304cb918eb:

  Smack: Restore the smackfsdef mount option (2019-05-28 10:22:04 -0700)

----------------------------------------------------------------
Casey Schaufler (1):
      Smack: Restore the smackfsdef mount option

 security/smack/smack_lsm.c | 2 ++
 1 file changed, 2 insertions(+)



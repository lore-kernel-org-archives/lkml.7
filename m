Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B3BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E272064C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XHyGSz3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfG2UUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:20:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:57285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728915AbfG2UUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564431626;
        bh=ioA2MeJW7/yd7h5DH6M9WRBDoHm8xA6Qpe6+IX8FnB0=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=XHyGSz3RLbIEa9iJiQeMShC5+895dEmzG2g+MCs+YhPxzZW46gPuGFg4dnWN/iO78
         x+BXYEuXYkUSFb2UV9M0+bZ5qFZ5fouaZrPGuNAg/f4op2OFELiQV9Vw694Rvfhn5J
         jwB0vURsqZYqpdMtTOd9OVUQ1Tc7oi1fPLP6fvI8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.24] ([95.116.7.70]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVvL5-1hza0q3ieT-00RqMn; Mon, 29
 Jul 2019 22:20:25 +0200
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: Kernel patch commit message and content do differ
Openpgp: preference=signencrypt
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 mQSuBFKhflgRDADrUSTZ9WJm+pL686syYr9SrBnaqul7zWKSq8XypEq0RNds0nEtAyON96pD
 xuMj26LNztqsEA0sB69PQq4yHno0TxA5+Fe3ulrDxAGBftSPgo/rpVKB//d6B8J8heyBlbiV
 y1TpPrOh3BEWzfqw6MyRwzxnRq6LlrRpiCRa/qAuxJXZ9HTEOVcLbeA6EdvLEBscz5Ksj/eH
 9Q3U97jr26sjFROwJ8YVUg+JKzmjQfvGmVOChmZqDb8WZJIE7yV6lJaPmuO4zXJxPyB3Ip6J
 iXor1vyBZYeTcf1eiMYAkaW0xRMYslZzV5RpUnwDIIXs4vLKt9W9/vzFS0Aevp8ysLEXnjjm
 e88iTtN5/wgVoRugh7hG8maZCdy3ArZ8SfjxSDNVsSdeisYQ3Tb4jRMlOr6KGwTUgQT2exyC
 2noq9DcBX0itNlX2MaLL/pPdrgUVz+Oui3Q4mCNC8EprhPz+Pj2Jw0TwAauZqlb1IdxfG5fD
 tFmV8VvG3BAE2zeGTS8sJycBAI+waDPhP5OptN8EyPGoLc6IwzHb9FsDa5qpwLpRiRcjDADb
 oBfXDt8vmH6Dg0oUYpqYyiXx7PmS/1z2WNLV+/+onAWV28tmFXd1YzYXlt1+koX57k7kMQbR
 rggc0C5erweKl/frKgCbBcLw+XjMuYk3KbMqb/wgwy74+V4Fd59k0ig7TrAfKnUFu1w40LHh
 RoSFKeNso114zi/oia8W3Rtr3H2u177A8PC/A5N34PHjGzQz11dUiJfFvQAi0tXO+WZkNj3V
 DSSSVYZdffGMGC+pu4YOypz6a+GjfFff3ruV5XGzF3ws2CiPPXWN7CDQK54ZEh2dDsAeskRu
 kE/olD2g5vVLtS8fpsM2rYkuDjiLHA6nBYtNECWwDB0ChH+Q6cIJNfp9puDxhWpUEpcLxKc+
 pD4meP1EPd6qNvIdbMLTlPZ190uhXYwWtO8JTCw5pLkpvRjYODCyCgk0ZQyTgrTUKOi/qaBn
 ChV2x7Wk5Uv5Kf9DRf1v5YzonO8GHbFfVInJmA7vxCN3a4D9pXPCSFjNEb6fjVhqqNxN8XZE
 GfpKPBMMAIKNhcutwFR7VMqtB0YnhwWBij0Nrmv22+yXzPGsGoQ0QzJ/FfXBZmgorA3V0liL
 9MGbGMwOovMAc56Zh9WfqRM8gvsItEZK8e0voSiG3P/9OitaSe8bCZ3ZjDSWm5zEC2ZOc1Pw
 VO1pOVgrTGY0bZ+xaI9Dx1WdiSCm1eL4BPcJbaXSNjRza2KFokKj+zpSmG5E36Kdn13VJxhV
 lWySzJ0x6s4eGVu8hDT4pkNpQUJXjzjSSGBy5SIwX+fNkDiXEuLLj2wlV23oUfCrMdTIyXu9
 Adn9ECc+vciNsCuSrYH4ut7gX0Rfh89OJj7bKLmSeJq2UdlU3IYmaBHqTmeXg84tYB2gLXaI
 MrEpMzvGxuxPpATNLhgBKf70QeJr8Wo8E0lMufX7ShKbBZyeMdFY5L3HBt0I7e4ev+FoLMzc
 FA9RuY9q5miLe9GJb7dyb/R89JNWNSG4tUCYcwxSkijaprBOsoMKK4Yfsz9RuNfYCn1HNykW
 1aC2Luct4lcLPtg44LQ1VG9yYWxmIEbDtnJzdGVyIChteSAybmQga2V5KSA8dG9yYWxmLmZv
 ZXJzdGVyQGdteC5kZT6IgQQTEQgAKQUCUqF+WAIbIwUJEswDAAcLCQgHAwIBBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEMTqzd4AdulO06EBAIBfWzAIRkMwpCEhY4ZHexa4Ge8C/ql/sBiW8+na
 FxbZAP9z0OgF2zcorcfdttWw0aolhmUBlOf14FWXYDEkHKrmlbkEDQRSoX5YEBAA2tKn0qf0
 kVKRPxCs8AledIwNuVcTplm9MQ+KOZBomOQz8PKru8WXXstQ6RA43zg2Q2WU//ly1sG9WwJN
 Mzbo5d+8+KqgBD0zKKM+sfTLi1zIH3QmeplEHzyv2gN6fe8CuIhCsVhTNTFgaBTXm/aEUvTI
 zn7DIhatKmtGYjSmIwRKP8KuUDF/vQ1UQUvKVJX3/Z0bBXFY8VF/2qYXZRdj+Hm8mhRtmopQ
 oTHTWd+vaT7WqTnvHqKzTPIm++GxjoWjchhtFTfYZDkkF1ETc18YXXT1aipZCI3BvZRCP4HT
 hiAC5Y0aITZKfHtrjKt13sg7KTw4rpCcNgo67IQmyPBOsu2+ddEUqWDrem/zcFYQ360dzBfY
 tJx2oSspVZ4g8pFrvCccdShx3DyVshZWkwHAsxMUES+Bs2LLgFTcGUlD4Z5O9AyjRR8FTndU
 7Xo9M+sz3jsiccDYYlieSDD0Yx8dJZzAadFRTjBFHBDA7af1IWnGA6JY07ohnH8XzmRNbVFB
 /8E6AmFA6VpYG/SY02LAD9YGFdFRlEnN7xIDsLFbbiyvMY4LbjB91yBdPtaNQokYqA+uVFwO
 inHaLQVOfDo1JDwkXtqaSSUuWJyLkwTzqABNpBszw9jcpdXwwxXJMY6xLT0jiP8TxNU8EbjM
 TeC+CYMHaJoMmArKJ8VmTerMZFsAAwUQAJ3vhEE+6s+wreHpqh/NQPWL6Ua5losTCVxY1snB
 3WXF6y9Qo6lWducVhDGNHjRRRJZihVHdqsXt8ZHz8zPjnusB+Fp6xxO7JUy3SvBWHbbBuheS
 fxxEPaRnWXEygI2JchSOKSJ8Dfeeu4H1bySt15uo4ryAJnZ+jPntwhncClxUJUYVMCOdk1PG
 j0FvWeCZFcQ+bapiZYNtju6BEs9OI73g9tiiioV1VTyuupnE+C/KTCpeI5wAN9s6PJ9LfYcl
 jOiTn+037ybQZROv8hVJ53jZafyvYJ/qTUnfDhkClv3SqskDtJGJ84BPKK5h3/U3y06lWFoi
 wrE22plnEUQDIjKWBHutns0qTF+HtdGpGo79xAlIqMXPafJhLS4zukeCvFDPW2PV3A3RKU7C
 /CbgGj/KsF6iPQXYkfF/0oexgP9W9BDSMdAFhbc92YbwNIctBp2Trh2ZEkioeU0ZMJqmqD3Z
 De/N0S87CA34PYmVuTRt/HFSx9KA4bAWJjTuq2jwJNcQVXTrbUhy2Et9rhzBylFrA3nuZHWf
 4Li6vBHn0bLP/8hos1GANVRMHudJ1x3hN68TXU8gxpjBkZkAUJwt0XThgIA3O8CiwEGs6aam
 oxxAJrASyu6cKI8VznuhPOQ9XdeAAXBg5F0hH/pQ532qH7zL9Z4lZ+DKHIp4AREawXNxiGYE
 GBEIAA8FAlKhflgCGwwFCRLMAwAACgkQxOrN3gB26U7PNwEAg6z1II04TFWGV6m8lR/0ZsDO
 15C9fRjklQTFemdCJugA+PvUpIsYgyqSb3OVodAWn4rnnVxPCHgDsANrWVgTO3w=
Message-ID: <ca2abaa5-c478-0b9f-cd51-c60aa032835f@gmx.de>
Date:   Mon, 29 Jul 2019 22:20:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2xd4Nyl8Ah7k1PesF/DOftuZF8+FG1JSvNUBEOOTxCAgIF8CiOe
 TiWm36WuuQqobmCqqHF1FndW4974mduo+FWEuqwafzg0IZErIZodiu8tWdnRzObfzir7WGS
 9cvS22fT9NNiLLTJirQGdBTyFX1S/STZCAXwFj/QGcRZSn7cDHHBK8rGfW+dbUbwgRB+XWo
 PCkxImsfot5dbncQDU31A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v3X9j6bwISk=:BKWE+4c4AsS9oWI0lddCzT
 B9g1LsoDu8+yYy83IF/HlxzzvzxPFW/C4CwAmXssLNWmqBT5uMjVDElZty6a6c3rSHU9w8A5L
 mjRuN5KXgCfGOHE5Ga6e+h0L4OOYAy88lIAt2KVIbKlik0FFH8LBGtJRq+6ilV3C18FmI8K11
 x5eLePQWJIvZty4g9V6rY0ChxYsu8GqqVd5HVQPijEPPenPioYYaFE8OgfcTQ0ZQcOHyFXETK
 pFWZS6CGsPGSGRumbe7FQgjxIcVtp0bhbzbYXiBDSo9N07gTcsNe5tLFwOZBCIco8RDdY1iAI
 da6TNLD2eHJXbThecWlE5lGROo/FpSbPdP1qZO6XBzgiOwE3noPvv0eNNZZpK44X8rC8PLt8n
 OIXUhB7K+klYuWsEkZrmWHB2Sp6CoeV/6JHYEoIwaZyJqYZG5bq8wetA0HHjK2M4UxBbbmbSi
 puhb3AGp00T3iX08+nlavfk3QjBhHPS4CzU85oWnMZsa+eAri/mC2/JOnB8CtQc/Fw1PlCanC
 V+Vo2IWicYLxqmdXf/5mbKtr0y1d4jnjm4htnlpR6D+3Bx+r5zWz8Pp4SVZY4/tTCHYQwM1+s
 2IFc02TwH0L3GO4R5OEjN7psFQtOGI0/0mvVGw+f/pJRl+EhexMTgSJ7A2+4FKIsy5vSGgxrK
 3SP2TYF/51JaWjm1b1CddGy2r2IB6Uxoz72IsxZIATDyiUZyaWIGG3+8Y4WffiPqdaGYHXUDY
 h12HdiNNUvXzCv2bg+Rx2uuG8/SnTChf7LlQjRT7ii5pHyBOlkHrD0Y2l4Y2MnqLes+oSoSV5
 RQecbj2vlxnQ/fdzyouCQeXPpXbivPoFAdId/SPoNK5cnUIwn5h6seG/K6GV8xZaMzd201Icw
 awKETjs2TO84F8SFXF250B1iQOte/4FYLdRK8VZSWpTSaVipy+NLATVsjD0K4+/oXpNEyy5RH
 F9cLUbVqv1R8INeFKhh9rQDYarNTIzsx4ovPjICY8t7AmHRlBtRpcYlISuGWl81F2BtVSB5SO
 2HKYeLPpUMjhY6GSI1HFTFE7zLQ5Ji9OXbHIU+X5z03Jtc2Wu5XAsYOhBJfpNzJDaRRcIbSsa
 9oaSJuLFNAhBlkGResSNQR9amywnw5bww9e
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May I ask you to clarify why https://git.kernel.org/pub/scm/linux/kernel/g=
it/stable/stable-queue.git/diff/queue-5.2/net-ipv4-fib_trie-avoid-cryptic-=
ternary-expressions.patch?id=3De1b76013997246a0d14b7443acbb393577d2a1e8 sp=
eaks about a ternary operator, whereas the diff shows a changed #define?


=2D-
Toralf
PGP C4EACDDE 0076E94E


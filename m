Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82634C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 15:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4664D20693
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 15:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfDUPG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 11:06:59 -0400
Received: from mail.grenz-bonn.de ([178.33.37.38]:54036 "EHLO
        mail.grenz-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfDUPG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 11:06:58 -0400
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Apr 2019 11:06:57 EDT
Received: from [192.168.178.151] (p57B0D1DA.dip0.t-ipconnect.de [87.176.209.218])
        by ks357529.kimsufi.com (Postfix) with ESMTPSA id 9D6C589A81;
        Sun, 21 Apr 2019 16:57:10 +0200 (CEST)
Subject: Re: [PATCH] ptrace.2: Improve clarity for multi-threaded tracers
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     mtk.manpages@gmail.com, linux-kernel@vger.kernel.org,
        cleverca22@gmail.com, linux-man@vger.kernel.org
References: <48bb7c89-abb9-1e88-fee3-fb42d4032d12@nh2.me>
 <bfa474c6-5b13-652d-2fd8-16b2be7efb62@nh2.me>
 <20190217221523.GA9233@altlinux.org>
From:   =?UTF-8?Q?Niklas_Hamb=c3=bcchen?= <mail@nh2.me>
Openpgp: preference=signencrypt
Autocrypt: addr=mail@nh2.me; prefer-encrypt=mutual; keydata=
 mQINBFZQegIBEADD2C+ODuFxK9XAQQqbP84M7y6gRDMIaFxqeT56g/pbe/wNjKATUQhJvaVJ
 /WbZ900KjMe8eo4Lg3uLbd6OxR2wb4OMkA7ogq87GefqyPvP3QhqkLhMjwoYim650PXqblgH
 W5VW1OPeUFBO4IMeHdMmO8cwNUUBlRY29Ld4VBSVCyZRgf10zy6IaWJRGaRnTSnSmHBVnM5H
 0EYlAeOrL7ZgA+xl+H9oGXRiDPTKiaPUhmRiVDjKCuqVmjx5H2armDs3DKu1e2g8o+52hN/d
 1+kgC5C801iXyV3r20+D24cuvkSZlKFQUavwBO9MnU5HcZROoJ4aVq1vnGqPwkcaumu8GJo/
 Nv2OsL60p2sMw6eoYZs9M7vtHyT9acEKm8GOZqb7vnE0i6yaqTkFn1MopmKDjbJzlayW9edw
 1P4IxAlGyh8DY/Rw/TyzC8Vyq9T30Q5PQOK32vJwrKfbQouG9LJA7/7pv/JA8PZJk2GvQJzG
 8L4pbxmDErRome+fNdFv5fkmFfvqBURFi08/96uaVJh1yKExiYC4qAyM2Ff7+k9K5lctHWtt
 zWeav3hhj2W472++Gy8Q4EOGciFih/xCweDmIXvM0NlVf6rnN2EWGpD4fV3WwD0dopO6LgvF
 pKYd6Vu08rzVHeXTFcFM2+Sqn01bWSnwOHlipELBNwSTRTtdVwARAQABtB9OaWtsYXMgSGFt
 YnVlY2hlbiA8bWFpbEBuaDIubWU+iQI9BBMBAgAnAhsDAh4BAheABQsJCAcDBRUKCQgLBRYC
 AwEABQJcrJMpBQkPwhqmAAoJEKw0Mmot+/oD0ocQALwvyzAnjK5+kWr1K5BLpyTaNWcsjqur
 0K76jMeU9rWWJOE1XIEDs7SLki5eqVwi8+aT3ix4NWKgWekxJA/vc1def5Pb6yH3Pqvz/LMZ
 ucXwbluwFY8PhKbJW9UqGhkTZuUGR3qhtcv3ADiVf+pF+9ezLC16gQw5dWjmgVUkpJuaKDCe
 ghbtgoN32TmZ3Wcz01SqpSrXjvrAuzJ7DsUEFhJ+eBX4nDaNtY/PXUWHP1JpqX8uLKigWd55
 /KcUCntZHHTTZqXWN1f8ltNxLfPq45+fJu2ppB32SazSNO3k4MFRsQ7Xxx8tyP2TLl94G6c/
 OOaWeMlDsSLL1s15DY9sALjhA143wC5g6Jt2kR4Hbj4ycOEEqbujljH7h1CYHwst+9aSPAAM
 ElDcUzSgF6URVaOS6kpgOU9PpmVOgwGEill4HTroW6V1uYKQytwVEhG7xaUMfHUYvg/N7quh
 /QymVdUiwVWPawZM0PH12PyEEdsJmgxdpGnmOC87mr7wB0gYQPps/fYDGjmfzOnNbAyqhLHu
 KlVC7S2oDPrgucLmwbNMiBUTRazNz4Voaet5ZoDiUX1iPpgpSlpI16um3r68oSWSTgBrcKfu
 OzgyxwMdzpEfGBfVVecSNaMcpa0s3EJ17zOA9aAofmzQoPWPUB8eWnEmIaMqhk2n6n7KtBAY
 EmdEuQENBFZQfyYBCACg6zeyjQmgV7AL0uCPhRJ79mgNzGST95f6t97oiYUiRM/MgUtsTeUM
 f30sN4QzvvUzeC+M4zFEaGkJhGdGGaMIkI26lItvBHqv9j24DOsrHhi9oRfFMKsqIoD43B5Y
 L6fgt9XBEFGM9SlM42lRDBlLsCcUYuCqxDF94K2d1pljUvx+aGUJUnkjCOyejO++Pm4TYX5E
 M1Hou+ZhmTyP5UFDUoNlgKW2KYkXsFLD53ukPaDoeDqq8ZL9ChAemWZ9sHHzrKp1wQHTmlMF
 E7HDNES8A1xuEmS3ud/snipUEEmA6qjGfYW32PTb2OZ4LxwTtY6/vn2K2uHJ9OTDoJ+3Tlaz
 ABEBAAGJAiUEGAECAA8FAlZQfyYCGwwFCQtHNQAACgkQrDQyai37+gOXfQ//di6ZYmpvXkYb
 osb36AOnKV//aZITAKnI7shbLmmODYUCJ99uvl9UWbFUYB3hYYU3mBavi9ptjQ3fXwLNiska
 qleRMA6segCcMmy//dflSBttleeF3YH6Vu5j6aL74izSI+oMTkCBUaiEVjDIMD5DMzVNIhgw
 etMSI4NTyvkKKd3IRyiPd7gofLWc7QtkZDIQuBzAnSZTCWXKyzPoo0uI9I5f16iYG5dCr/oz
 aR+sINGvRvjJKo0BlR1BeT2NBHBW9dwJpKgoijgt2YNE+Da0BoK+1xk0FAR8zCCSOuMXa35h
 Lay94cp/uR+8/XGuWYUIKDRfE4WZITpbzaipeSdGHHfkPs7H9X5CbRNAut6HQAMjMf3ASCeq
 iU3TFKgBt3Z75oN7M6jMHLtPIx8yJD+2UEgbPRT9ZBU8O2Wh77Yl3NyejUbRALVjW8WSTPuA
 YOgM7Xa8R4klu4UepVCJvQNKxb7IGCuQrJ3biaJiTp4VReqznQW0gGZfS/bLPV5Mlk74W8yF
 b/9fmV/w9F9NPAcKJMwTrnzZNNUEGxd6BMEp08MtVJsfj+UD9Bp1kBM/syQ7baKBRAQ3daeb
 Zr5NaitymrYTzfscuoyM2dSUKvbthGksMzSQuUi4K/f7o02Em4xV3RUMLaeddtJnuIHVIwK3
 I5iUn4z57nU2AqjbZ2GHAwqJAiUEGAECAA8CGwwFAlyskyIFCQ/CFXwACgkQrDQyai37+gOb
 FRAAmbtC09r555b/1biWF8WqYA9eQhF3NAJqkU8EJAtzQ0AIu8WTWGA9+L1v/uioM3pbDONq
 IFuEtLXChC21/KXxvXhj75hlblTBbmCmdOkH7h4N2ViLj6PJofxjnoItB5kWZVENKifm9tLZ
 QhmGV3TcDqkfDc8wlqlJcMZzFCp1iENbvk4CcjfAI830nzRmwtjrbareV9yhiOWflwRjKx5N
 ZFeyDUgV4v0SU1XFtSmWHYVaTZx9deUsIP6zYJ1X5gFQQDXvKW9M3UAa/HagAjjQpZnmJ4FY
 /8M94F3rpnGcjXuZVEWaTHpYtE9rRw4CaICd8qzWHLb7quL/Ijg7HG/kwUFG7J1Cjtl2xNE5
 +qbzhzV62sTBM2iKoy5kl9rz/a9/dyivgQDIj4/fhKAsl/gUxZHCGOgF8Tg6w+2WAeJivRsq
 nkgZj/WKb78Vo/kjRtO8y4zzxlnanlHCWjflfCxMonQJi4JY0DkvRab33s+bVUdX7S8WbQqV
 54n9R6u05ni64Kbbjbu1gIFYdaXI6G9VN2MQDXZ4Tc1hIeNBsXTNvzPs//e6jj/LJKkom/ab
 K47j21UvYJ/k3dbGv/914KV/5Gi5UPpWA4a6NijRMbU6+xD8DPuCVDEaDYZEfEmFqLNEQ1Lq
 kfwWbZGwgHzRWBUOCm/C5afDKRk9vLSI8zyaJfO5AQ0EVlCBowEIAMWqzE9KBPpYGr6xyBda
 QYrYh2dysWKT5T/G0f3vtpvd75U3l/HU1xbREWWte0dpfNWbBGN/kXewjbfxtMlYHqKtkOR9
 g0cZlNPEbITcNDDlLUkDawboiXF0jJNW7RLZ4F9S1EsicyUmGcV/Rgf3Mvt4cdRQ6gWNBE7A
 OLiG4uiycoSz1yN3EJTftRIQkR0OsQSAq1J+3hdQ8gFS/D7FzVSph0nO+ctaaOlmpFTtTmo+
 ru1rAFE9IoiKSq6IqLeGMgDiAfOAwPhOeXsQWv/tVAGQg4ScblcUK96P6aJsmza0Yh+LCizm
 Rw0ddlvsrgB9eZcJofDgwz11rvlnFfcMJtsAEQEAAYkDRAQYAQIADwUCVlCBowIbAgUJC0c1
 AAEpCRCsNDJqLfv6A8BdIAQZAQIABgUCVlCBowAKCRB/5SIGoqDomJzTB/4v2iIagjt/e6ex
 uSS0Nd27/+GC+/Uf39r1oiIcJ5ir0I44LxSf5R9Za4LBU9M1ULmpahdxFnUPDxaChZQmdHo9
 PhF+H/3MIWMpoeCSTbfreQC9uQ58axKEFmAZGXV4UjYt6vRvZyZ3MClKc0eGytvEyv3BlTk0
 xnp9BjubaCabeB7VxoRlIhyCZl0tTh72lajmD7W7Srt4ai4Cn+BVFbVLzkgOWjtHFhlK1nMg
 6xTspb1i6k3Hekq3L3bOEoDaJOWakj5uLhaJDyF7Z5530utuXISskKRIxtp72O79upOW52Xt
 XzFkP9ZSnEyjRLIrbbvqVLtEAKLsb3+fLiwsiTFhmpcP/2apZo3qOHeF5QGIWV1XMQt3JR3x
 lGEw7/62yBZ70W/lH9vE6RDrbndeCSuvsw6opYtWFNSI/YEXvv9bklLNMEYuTGPejDNG7yZy
 ol+f0gLR3LscPSs/pScTeS/bDKVTwMKHuiSKlEz6cnvybnvN9UmX0Z95n83GG/0heR8HYMsL
 uHtXkaVYzUAR9TElF//Bs2fleC4X2eNLMQsMeWfWFWldnEqoGKsVLyBefr7uq+NM1r61j9Nu
 /k6VS9fHCo7zClRf+tPLk5s5gR6JuW0DHMSUnRTE54CYPzZZ+1xrkyarTtS+hqgatDEB5XUS
 SsJM5Va1ZM/mfGzfpEJIVQluR/Iu7ohUVBJOz89xsdjC8oj47kwU3NFUTx9Vkc1ukeCHLa39
 X8+gk+PzOHRVrYVFfODOoCPI4CuKW1vm2OPvIzm3XbmOLrKpXkesu5pt9VVfnSS1aizk+4+M
 YV33aI116PXPcsBDytvZcLAxhE2b1PDpvOC9PdVt1v/jxChHwBfXd/2Ng+l2uPfwI+nFSZEi
 btXLgLBMPLVgbo1he7QJ9dc+kl1cPTnyutJ0+Zhvt039HC+Z6blnAKqWUZTsjf9BxpVtd+UC
 vFcxusu5px5sLydUD30WsQUIwidiZ0HRXH0CMSNJ36heuLzc3p0K7WUhjQy4BL4NXHSzq11a
 ER7m2GqwiQNEBBgBAgAPAhsCBQJcrJMwBQkPwhMNASnAXSAEGQECAAYFAlZQgaMACgkQf+Ui
 BqKg6Jic0wf+L9oiGoI7f3unsbkktDXdu//hgvv1H9/a9aIiHCeYq9COOC8Un+UfWWuCwVPT
 NVC5qWoXcRZ1Dw8WgoWUJnR6PT4Rfh/9zCFjKaHgkk2363kAvbkOfGsShBZgGRl1eFI2Ler0
 b2cmdzApSnNHhsrbxMr9wZU5NMZ6fQY7m2gmm3ge1caEZSIcgmZdLU4e9pWo5g+1u0q7eGou
 Ap/gVRW1S85IDlo7RxYZStZzIOsU7KW9YupNx3pKty92zhKA2iTlmpI+bi4WiQ8he2eed9Lr
 blyErJCkSMbae9ju/bqTludl7V8xZD/WUpxMo0SyK2276lS7RACi7G9/ny4sLIkxYQkQrDQy
 ai37+gPhRA//TTwZTfb/HkrM9oGrEhfIKiHVoH6o5SRB2I9H0p7cblncArvaNecD8cHfbF2s
 8SRcChCX+RBIj0MSfqWstEEdvuRQJGezqvygo5Pj1qoH1Uopi9IsG+3sq3kSvUjD+DcnZ4Cb
 IshzoDDc/hHhbeQvAioY9fCTBg+XhlzjjawtMCamzTyPvAtkI6E5xzqTC5/HNLGcXdMls4uc
 SHXOdAdUFn1jRgtwXLEk20krJ/QBi8O7jg2TSrgLyQ3P9GDhXZsH6hEhoKUpsRHxu6e2wRMs
 frQldWRH+1tsRnNjR1IAibyN+6ToCf/SbHlOkrrhsp+y8gsIiUyhcKvYVnUR103ly1GsC+F6
 N6MTQwG0JG6i0k6Si0wVuNsXwIg91Ft8YDl50wIm7MQRsB5fkV+eckM407FtQNlEorVgGmrq
 XHxzyMBH0wf8LFkfglOX0LBpxSucLcMxlVDCjOUm8JM1GyKYZFfqsVlHkncR7CKI8xyjxz+A
 6NGMsDuaqJ8h/fVs+MxDehnaVnvIF7TDGv9jz3mgqzbrToGXAmpzhhVM3RWIora1j91WzMSL
 +KN/YNvJggdPofH4QwVocD3pSXnLMOdqya8mwBv1pHdwSL4Ug7RAWIVgeBAv0ufeElOJQNjp
 pg16v3C1dl0LUhDYFBJRnknYxq7yCFUZHRl2VpbnzV1aQ2g=
Message-ID: <cea5f7cb-c6be-080e-3d1a-335da4b74b39@nh2.me>
Date:   Sun, 21 Apr 2019 16:57:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190217221523.GA9233@altlinux.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OwGNQNSqQVOvD1aGOIshAm1E6dQ5YxdCU"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OwGNQNSqQVOvD1aGOIshAm1E6dQ5YxdCU
Content-Type: multipart/mixed; boundary="RkaQJYhghPjFx7gWx18EeWMq1qyJtc18B";
 protected-headers="v1"
From: =?UTF-8?Q?Niklas_Hamb=c3=bcchen?= <mail@nh2.me>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: mtk.manpages@gmail.com, linux-kernel@vger.kernel.org,
 cleverca22@gmail.com, linux-man@vger.kernel.org
Message-ID: <cea5f7cb-c6be-080e-3d1a-335da4b74b39@nh2.me>
Subject: Re: [PATCH] ptrace.2: Improve clarity for multi-threaded tracers
References: <48bb7c89-abb9-1e88-fee3-fb42d4032d12@nh2.me>
 <bfa474c6-5b13-652d-2fd8-16b2be7efb62@nh2.me>
 <20190217221523.GA9233@altlinux.org>
In-Reply-To: <20190217221523.GA9233@altlinux.org>

--RkaQJYhghPjFx7gWx18EeWMq1qyJtc18B
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hey Dmitry,

On 2019-02-17 23:15, Dmitry V. Levin wrote:
>>  A tracee first needs to be attached to the tracer.
>> -Attachment and subsequent commands are per thread:
>> -in a multithreaded process,
>> +Attachment and subsequent commands are per thread,
>> +on both the tracer and tracee side.
>> +Issuing a tracing command from a thread that is not the tracer of the=
 given
>> +.I pid
>> +will result in an
>> +.B ESRCH
>> +error.
>=20
> This is confusing.  What do you mean by a tracing command?
> Is PTRACE_TRACEME a tracing command?  PTRACE_ATTACH?  PTRACE_SEIZE?

I was referring to the same command as in other places in the man page, a=
s in the existing sentences

    Most ptrace commands [...] require the tracee to be in a  ptrace-stop=
, otherwise they fail with ESRCH.

or

    (for commands which require a stopped tracee)

Would thus "ptrace command" be better than "tracing command" here?

>>  .B ESRCH
>>  The specified process does not exist, or is not currently being trace=
d
>> -by the caller, or is not stopped
>> +by the calling thread, or is not stopped
>>  (for requests that require a stopped tracee).
>>  .SH CONFORMING TO
>>  SVr4, 4.3BSD.
>=20
> I agree the current text can be made more clear on the subject,
> but, unfortunately, proposed change makes the description more confusin=
g.

Do you mean "calling thread" is more confusing than "caller"?
If yes, what would you suggest instead?

My intent here was to, for anybody who encounters ESRCH and looks it up i=
n an effort to see what's going on, make clear that threads are important=
 here.

Or should I switch to `task_struct` terminology? That wouldn't be userspa=
ce terminology though, and the rest of the man page also talks about thre=
ads.


Niklas


--RkaQJYhghPjFx7gWx18EeWMq1qyJtc18B--

--OwGNQNSqQVOvD1aGOIshAm1E6dQ5YxdCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJcvITDAAoJEH/lIgaioOiYJ0gIALbn+rsRbApXNSZl+9y6GyHT
kOgocyW1akd5xxSzIgDRsshEsLZkJ2PD/u6wyvYbz+7NMPH5gFp3meIRKQgrtqZR
+ORnn9Oa6Lc4dlK1EfiSliEEooCpnhj/vihdkUt44t7qtbNEY8G3XmIZ0Wfo3Leo
7PatUwWNzwwvR29ZkNao7JC0gCMX5iSwXE5iUtSQEnitfI9PaYPSzylVqsboi7oN
zqNfedrL2cBlRg9yJ8kzOjG2qotuSssmPSj9UHQB88kxXro1nKhQvvkPKgfTtxxL
WkrnVdj7bAOf0/51EimZ/2whd5ssvuJvDINFd7lXCnW/WL0nvXrHTuLqmEigp7w=
=KcYI
-----END PGP SIGNATURE-----

--OwGNQNSqQVOvD1aGOIshAm1E6dQ5YxdCU--
